import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/auth_notifier.dart';
import '../utils/text_const.dart';
import '../utils/text_style_const.dart';
import '../utils/theme_manager.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    AuthNotifer authNotifier = Provider.of(context, listen: true);

    return Drawer(
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(
          top: 9.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----------- userProfile----------------
            auth.currentUser!.photoURL == null
                ? Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 3.h),
                    height: 10.h,
                    width: 10.h,
                    decoration: BoxDecoration(
                        color: ThemeManager().getGreenColor,
                        shape: BoxShape.circle),
                    child: Text(
                      "P",
                      style: poppinsBold.copyWith(
                          fontSize: 18.sp, color: ThemeManager().getWhiteColor),
                    ),
                  )
                : Image.network(auth.currentUser!.photoURL!),

            ///---------------- divider -------------------
            Divider(
              thickness: 1,
            ),

            ///--------------------- options----------------
            Container(
              margin: EdgeInsets.only(left: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///--------------------- categories_Link ----------------

                  GestureDetector(
                    onTap: () {
                      authNotifier.onIndexChanged(0);
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 3.h, bottom: 3.h),
                        child: commonTextWidget(TextConst.categories_Link)),
                  ),

                  ///--------------------- user_profile ----------------

                  GestureDetector(
                    onTap: () {
                      authNotifier.onIndexChanged(2);
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 3.h),
                        child: commonTextWidget(TextConst.user_profile)),
                  ),

                  ///--------------------- logout ----------------

                  GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await authNotifier.signOut(context);
                      },
                      child: commonTextWidget(TextConst.logout))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget commonTextWidget(String text) {
    return Text(
      text,
      style: poppinsMedium.copyWith(
          fontSize: 13.sp, color: ThemeManager().getBlackColor),
    );
  }
}
