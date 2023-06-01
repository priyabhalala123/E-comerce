import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../provider/home_notifier.dart';
import '../../../utils/text_style_const.dart';
import '../../../utils/theme_manager.dart';
import '../home/product_details_screen.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  Widget build(BuildContext context) {
    HomeNotifier homeNotifier = Provider.of(context, listen: true);

    return Container(
      margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 2.h, top: 3.h),
      child: GridView.builder(
          padding: EdgeInsets.only(top: 1.5.h),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: homeNotifier.addToCart.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5.w,
              childAspectRatio: 0.62,
              crossAxisSpacing: 5.w),
          itemBuilder: (BuildContext context, int index) {
            var productData = homeNotifier.addToCart[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(productData: productData),
                    ));
              },
              child: Container(
                  padding: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 1.h),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: ThemeManager().getBlackColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///------------ product image------------
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
                        child: CachedNetworkImage(
                          imageUrl: productData.image!,
                          height: 10.h,
                          width: 10.h,
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
                        margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
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
                        initialRating:
                            double.parse(productData.rating!.rate!.toString()),
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

                    ],
                  )),
            );
          }),
    );
  }
}
