import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/color_const.dart';
import '../utils/text_style_const.dart';
import '../utils/theme_manager.dart';

class CommonButton extends StatefulWidget {
  final String text;
  final bool isLoading;

  const CommonButton({super.key, required this.text, this.isLoading = false});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5.h,
      width: 100.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ThemeManager().getGreenColor,
          borderRadius: BorderRadius.circular(7)),
      child: widget.isLoading
          ? Container(
              height: 3.h,
              width: 3.h,
              child: CircularProgressIndicator(
                color: ThemeManager().getWhiteColor,
                strokeWidth: 4,
              ),
            )
          : Text(
              widget.text,
              style: poppinsMedium.copyWith(
                fontSize: 12.sp,
                color: ThemeManager().getWhiteColor,
              ),
            ),
    );
  }
}
