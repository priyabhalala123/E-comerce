import 'package:e_commerce/utils/theme_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';
import '../../provider/auth_notifier.dart';
import '../../utils/color_const.dart';
import '../../utils/image_const.dart';
import '../../utils/text_const.dart';
import '../../utils/text_style_const.dart';
import '../../widget/commonButton.dart';
import '../../widget/commonTextFielde.dart';
import '../../widget/scaffold_snackbar.dart';
import '../../widget/validation.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var formKey = GlobalKey<FormState>();

  TextEditingController _emailAddress = TextEditingController();

  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthNotifer authNotifier = Provider.of(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
          child: Column(
            children: [
              Text(
                TextConst.signUp.toUpperCase(),
                style: poppinsMedium.copyWith(
                    fontSize: 20.sp, color: ThemeManager().getBlackColor),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ///-------------------- logo  ------------------------
                      Container(
                        margin: EdgeInsets.only(bottom: 5.h, top: 4.h),
                        child: Image.asset(
                          ImageConst.login_image,
                          height: 27.h,
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 6.h),
                          child: Column(
                            children: [
                              ///------------- email address ---------

                              CommanTextFromFiled(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailAddress,
                                hintText: TextConst.mail,
                                validator: isValidEmail,
                                suffixIcon: Image.asset(
                                  ImageConst.mail,
                                  scale: 3.5,
                                ),
                              ),

                              ///------------- Password ---------

                              CommanTextFromFiled(
                                obscureText: authNotifier.obscureText,
                                controller: _password,
                                hintText: TextConst.password,
                                validator: isValidpassword,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    authNotifier.isObscureText();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 3.w),
                                    child: Icon(
                                      authNotifier.obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: ThemeManager().getGreyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///-------------------- sign up  buttton ------------------------

                      GestureDetector(
                        onTap: () async {
                          final isValid = formKey.currentState!.validate();
                          if (isValid) {
                            authNotifier.isLoading = true;
                            FocusScope.of(context).requestFocus(FocusNode());
                            await authNotifier.signUpWithEmailAndPassword(
                                context, _emailAddress.text, _password.text);

                            ///------ login part----
                          }
                        },
                        child: CommonButton(
                          text: TextConst.signUp.toUpperCase(),
                          isLoading: authNotifier.isLoading,
                        ),
                      ),

                      ///------------ Already have account------------------

                      Container(
                        margin: EdgeInsets.only(top: 3.h),
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: TextConst.alreadyHaveAccount + " ",
                            style: poppinsMedium.copyWith(
                                fontSize: 12.sp,
                                color: ThemeManager().getBlackColor),
                            children: [
                              TextSpan(
                                text: TextConst.login,
                                style: poppinsMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: ThemeManager().getGreenColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, Routes.login);
                                  },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
