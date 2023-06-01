import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/auth_notifier.dart';
import '../../utils/text_style_const.dart';
import '../../utils/theme_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthNotifer authNotifier = Provider.of(context, listen: true);

    return Container(
      margin: EdgeInsets.only(top: 3.h, left: 4.w, right: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///----------- userProfile----------------
          auth.currentUser!.photoURL == null
              ? Center(
                  child: Container(
                    alignment: Alignment.center,
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
                  ),
                )
              : Image.network(auth.currentUser!.photoURL!),

          ///----------- User name ----------------
          Container(
            margin: EdgeInsets.only(top: 2.h),
            child: commonTextWidget(auth.currentUser!.displayName == null ||
                    auth.currentUser!.displayName == ""
                ? 'Priya'
                : auth.currentUser!.displayName!),
          ),
          commonTextWidget(auth.currentUser!.email!)
        ],
      ),
    );
  }

  Widget commonTextWidget(String text) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ThemeManager().getGreyColor)),
      child: Text(
        text,
        style: poppinsMedium.copyWith(
            fontSize: 11.sp, color: ThemeManager().getBlackColor),
      ),
    );
  }
}
