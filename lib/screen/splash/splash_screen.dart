import 'dart:async';

import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../shared_preference/sharedPreference.dart';
import '../../utils/image_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";
  @override
  void initState() {
    sendToNextScreen();
    super.initState();
  }

  sendToNextScreen() {
    Timer(const Duration(seconds: 2), () async {
      bool isAlreadyLogin = await PrefServices().getIsUserLoggedIn();
      if (isAlreadyLogin == true) {
        Navigator.pushReplacementNamed(context, Routes.bottomNavigationBar);
      } else {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,

        ///-------------------- splash logo ------------------------
        child: Image.asset(
          ImageConst.splash_logo,
          height: 27.h,
        ),
      ),
    );
  }
}
