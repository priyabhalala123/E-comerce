import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../utils/color_const.dart';
import '../utils/text_style_const.dart';
import '../utils/theme_manager.dart';

class CommanTextFromFiled extends StatefulWidget {
  final Function()? onTap;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool? enabled;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const CommanTextFromFiled(
      {super.key,
      this.onTap,
      required this.controller,
      this.prefixIcon,
      this.suffixIcon,
      required this.hintText,
      this.validator,
      this.keyboardType,
      this.enabled = true,
      this.inputFormatters,
      this.obscureText = false});

  @override
  State<CommanTextFromFiled> createState() => _CommanTextFromFiledState();
}

class _CommanTextFromFiledState extends State<CommanTextFromFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.obscureText,
        enabled: widget.enabled,
        style: poppinsRegular.copyWith(
            fontSize: 12.sp, color: ThemeManager().getGreyColor),
        controller: widget.controller,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          errorMaxLines: 2,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.5.w),
              borderSide: BorderSide(color: ThemeManager().getGreyColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.5.w),
              borderSide: BorderSide(color: ThemeManager().getGreyColor)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.5.w),
              borderSide: BorderSide(color: ThemeManager().getGreyColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2.5.w),
              borderSide: BorderSide(color: ThemeManager().getGreyColor)),
          hintStyle:
              poppinsRegular.copyWith(color: ThemeManager().getGreyColor),
          hintText: widget.hintText,
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
        ),
      ),
    );
  }
}
