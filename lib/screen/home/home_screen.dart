import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/provider/home_notifier.dart';
import 'package:e_commerce/screen/home/product_details_screen.dart';
import 'package:e_commerce/utils/image_const.dart';
import 'package:e_commerce/utils/text_const.dart';
import 'package:e_commerce/utils/text_style_const.dart';
import 'package:e_commerce/utils/theme_manager.dart';
import 'package:e_commerce/widget/commonButton.dart';
import 'package:e_commerce/widget/commonTextFielde.dart';
import 'package:e_commerce/widget/scaffold_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_model.dart';
import '../../shared_preference/sharedPreference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getSliderImages();
    super.initState();
  }

  final CarouselController _controller = CarouselController();

  final random = Random();

  List<int> productId = [];
  getSliderImages() async {
    HomeNotifier homeNotifier = Provider.of(context, listen: false);
    await homeNotifier.getImages();
    await homeNotifier.getProducts();
    homeNotifier.searchList = homeNotifier.productsModel;

    var cartData = await PrefServices().getCartData();
    if (cartData != "") {
      homeNotifier.addToCart = getProductModellFromJson(cartData);
      homeNotifier.addToCart.forEach((element) {
        productId.add(element.id!);
      });
      print("get cart addToCart======>${homeNotifier.addToCart.length}");
    }
  }

  TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  _HomeScreenState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(
          () {
            _searchText = "";
            _buildSearchList();
          },
        );
      } else {
        setState(
          () {
            _searchText = _searchController.text;
            _buildSearchList();
          },
        );
      }
    });
  }
  _buildSearchList() {
    HomeNotifier homeNotifier = Provider.of(context, listen: false);

    if (_searchText.isEmpty) {
      homeNotifier.searchList = homeNotifier.productsModel;
    } else {
      homeNotifier.searchList = homeNotifier.productsModel
          .where((element) => (element.title!.toLowerCase().contains(
                    _searchText.toLowerCase(),
                  ) ||
              element.category!.toLowerCase().contains(
                    _searchText.toLowerCase(),
                  )))
          .toList();

      return homeNotifier.searchList;
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeNotifier homeNotifier = Provider.of(context, listen: true);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///----------- search field---------------
            Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 1.h),
              child: CommanTextFromFiled(
                controller: _searchController,
                hintText: TextConst.search,
                suffixIcon: Image.asset(
                  ImageConst.search,
                  scale: 4,
                ),
              ),
            ),

            ///----------- image slider ---------------

            Container(
              margin: EdgeInsets.only(top: 1.5.h),
              child: CarouselSlider(
                items: homeNotifier.imagesDataModel
                    .map((e) => CachedNetworkImage(
                          imageUrl: e.downloadUrl!,
                          width: 100.w,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: ThemeManager().getGreenColor,
                              ),
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ))
                    .toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  aspectRatio: 2.6,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    homeNotifier.onIndexChanged(index);
                  },
                ),
              ),
            ),

            ///----------- list of product ---------------

            Container(
              margin:
                  EdgeInsets.only(left: 3.w, right: 3.w, bottom: 2.h, top: 3.h),
              child: homeNotifier.searchList.isEmpty
                  ? Text(
                      "No data found",
                      style: poppinsBold.copyWith(
                        fontSize: 10.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : GridView.builder(
                      padding: EdgeInsets.only(top: 1.5.h),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: homeNotifier.searchList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.w,
                          childAspectRatio: 0.57,
                          crossAxisSpacing: 5.w),
                      itemBuilder: (BuildContext context, int index) {
                        var productData = homeNotifier.searchList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                      productData: productData),
                                ));
                          },
                          child: Container(
                              padding: EdgeInsets.only(left: 3.w, right: 3.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ThemeManager().getBlackColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///------------ product image------------
                                  Container(
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.only(top: 1.h, bottom: 1.h),
                                    child: CachedNetworkImage(
                                      imageUrl: productData.image!,
                                      height: 10.h,
                                      width: 10.h,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            color: ThemeManager().getGreenColor,
                                          ),
                                        ],
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),

                                  ///------------ product category------------

                                  Text(
                                    productData.category!,
                                    style: poppinsBold.copyWith(
                                      fontSize: 10.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  ///------------ product title------------

                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 1.h, bottom: 1.h),
                                    child: Text(
                                      productData.title!,
                                      style: poppinsRegular.copyWith(
                                        fontSize: 10.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  ///------------ product description ------------

                                  Text(
                                    productData.description!,
                                    style: poppinsRegular.copyWith(
                                      fontSize: 8.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  ///------------ product price ------------

                                  Container(
                                    margin: EdgeInsets.only(top: 1.h),
                                    child: Text(
                                      productData.price!.toString(),
                                      style: poppinsMedium.copyWith(
                                        fontSize: 10.sp,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  ///------------ rating------------

                                  RatingBar.builder(
                                    initialRating: double.parse(
                                        productData.rating!.rate!.toString()),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),

                                  ///-------- add to cart button -----------------
                                  GestureDetector(
                                    onTap: () {
                                      if (homeNotifier.addToCart.isEmpty) {
                                        homeNotifier.addToCart.add(productData);
                                        productId.add(productData.id!);
                                        ScaffoldSnackbar.of(context).show(
                                            "Your item is added into cart");
                                        var cartData =
                                            jsonEncode(homeNotifier.addToCart);
                                        print("cartData=====>$cartData");
                                        PrefServices().setCartData(cartData);
                                      } else {
                                        if (productId
                                            .contains(productData.id)) {
                                          ScaffoldSnackbar.of(context).show(
                                              "Your item is already added into cart");
                                        } else {
                                          homeNotifier.addToCart
                                              .add(productData);
                                          productId.add(productData.id!);
                                          var cartData = jsonEncode(
                                              homeNotifier.addToCart);
                                          print("cartData=====>$cartData");
                                          PrefServices().setCartData(cartData);
                                          ScaffoldSnackbar.of(context).show(
                                              "Your item is added into cart");
                                        }
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 1.h, bottom: 1.h),
                                        child: CommonButton(
                                            text: TextConst.addToCart)),
                                  )
                                ],
                              )),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
