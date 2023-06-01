import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/color_const.dart';
import 'package:e_commerce/utils/text_const.dart';
import 'package:e_commerce/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../../model/product_model.dart';
import '../../utils/text_style_const.dart';
import '../../widget/commonButton.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductsModel productData;
  const ProductDetailsScreen({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager().getWhiteColor,

      ///--------- appbar---------
      appBar: AppBar(
        iconTheme: IconThemeData(color: ThemeManager().getBlackColor),
        elevation: 0,
        backgroundColor: ThemeManager().getWhiteColor,
        title: Text(
          productData.title!,
          style: poppinsMedium.copyWith(
              fontSize: 11.sp, color: ThemeManager().getBlackColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 4.w, right: 4.w),
        children: [
          ///---------- image------------
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
            child: CachedNetworkImage(
              imageUrl: productData.image!,
              height: 25.h,
              width: 25.h,
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
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),

          ///----------- category ------------
          CommonTextWidget(TextConst.category, productData.category!),

          ///----------- title ------------

          CommonTextWidget(TextConst.title, productData.title!),

          ///----------- description ------------

          CommonTextWidget(TextConst.description, productData.description!),

          ///----------- price ------------

          CommonTextWidget(TextConst.price, productData.price!.toString()),

          ///----------- rating ------------

          Container(
              margin: EdgeInsets.only(top: 1.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      TextConst.Rating,
                      style: poppinsBold.copyWith(
                          color: ThemeManager().getBlackColor, fontSize: 11.sp),
                    ),
                  ),

                  ///------------ stars------------

                  Expanded(
                    flex: 2,
                    child: RatingBar.builder(
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
                  ),
                ],
              ))
        ],
      ),
    );
  }

  CommonTextWidget(String text1, String text2) {
    return Container(
      margin: EdgeInsets.only(top: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              text1,
              style: poppinsBold.copyWith(
                  color: ThemeManager().getBlackColor, fontSize: 11.sp),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              text2,
              style: poppinsRegular.copyWith(
                  color: ThemeManager().getBlackColor, fontSize: 10.sp),
            ),
          ),
        ],
      ),
    );
  }
}
