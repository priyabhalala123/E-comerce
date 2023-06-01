import 'dart:io';

import 'package:e_commerce/screen/home/home_screen.dart';
import 'package:e_commerce/screen/profile/profile_screen.dart';
import 'package:e_commerce/utils/theme_manager.dart';
import 'package:e_commerce/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import '../../provider/auth_notifier.dart';
import '../../provider/home_notifier.dart';
import '../../utils/image_const.dart';
import '../../utils/text_style_const.dart';
import '../Cart/add_to_cart_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final int index;
  BottomNavigationBarScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  List screen = [HomeScreen(), AddToCartScreen(), ProfileScreen()];
  @override
  void initState() {
    AuthNotifer authNotifier = Provider.of(context, listen: false);

    authNotifier.currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifer authNotifier = Provider.of(context, listen: true);
    HomeNotifier homeNotifier = Provider.of(context, listen: true);
    List<BottomNavigationBarItem> lstOfBottomNavigationBar = [
      ///----------- Home-------------
      BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(top: 0.5.h),
          child: Image.asset(
            ImageConst.homeIcon,
            height: 6.w,
            width: 6.w,
            fit: BoxFit.contain,
          ),
        ),
        label: "Home",
        activeIcon: Container(
          margin: EdgeInsets.only(top: 0.5.h),
          child: Image.asset(
            ImageConst.homeIcon,
            color: ThemeManager().getGreenColor,
            height: 6.w,
            width: 6.w,
            fit: BoxFit.contain,
          ),
        ),
      ),

      ///----------- cart -------------

      BottomNavigationBarItem(
        icon: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Container(
              margin: EdgeInsets.only(top: 0.5.h),
              child: Image.asset(
                ImageConst.cart,
                height: 6.w,
                width: 7.w,
                fit: BoxFit.contain,
                color: ThemeManager().getGreyColor,
              ),
            ),
            Positioned(
              left: 5.w,
              child: CircleAvatar(
                radius: 7,
                backgroundColor: ThemeManager().getGreenColor,
                child: Container(
                  margin: EdgeInsets.only(bottom: 1),
                  child: Text(
                    homeNotifier.addToCart.isEmpty
                        ? "0"
                        : homeNotifier.addToCart.length.toString(),
                    style: poppinsBold.copyWith(
                        fontSize: 8.sp, color: ThemeManager().getWhiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
        label: "Cart",
        activeIcon: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.only(top: 0.5.h),
              child: Image.asset(
                ImageConst.cart,
                color: ThemeManager().getGreenColor,
                height: 6.w,
                width: 7.w,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              left: 5.w,
              child: CircleAvatar(
                radius: 7,
                backgroundColor: ThemeManager().getGreenColor,
                child: Container(
                  margin: EdgeInsets.only(bottom: 1),
                  child: Text(
                    homeNotifier.addToCart.isEmpty
                        ? "0"
                        : homeNotifier.addToCart.length.toString(),
                    style: poppinsBold.copyWith(
                        fontSize: 8.sp, color: ThemeManager().getWhiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      ///----------- profile-------------

      BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(top: 0.5.h),
          child: Image.asset(
            ImageConst.userProfileIcon,
            height: 6.w,
            width: 6.w,
            fit: BoxFit.contain,
          ),
        ),
        label: "Profile",
        activeIcon: Container(
          margin: EdgeInsets.only(top: 0.5.h),
          child: Image.asset(
            ImageConst.userProfileIcon,
            color: ThemeManager().getGreenColor,
            height: 6.w,
            width: 6.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        backgroundColor: ThemeManager().getWhiteColor,

        ///-------------- appbar-------------
        appBar: AppBar(
          title: Text(authNotifier.currentIndex == 0
              ? "Home"
              : authNotifier.currentIndex == 1
                  ? "Cart"
                  : "Profile"),
          centerTitle: true,
          backgroundColor: ThemeManager().getGreenColor,
        ),

        ///-------------- Drawer -----------
        drawer: CommonDrawer(),

        body: screen[authNotifier.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          useLegacyColorScheme: false,
          selectedLabelStyle: poppinsMedium.copyWith(
              color: ThemeManager().getGreenColor, fontSize: 10.sp, height: 2),
          unselectedLabelStyle: poppinsRegular.copyWith(
              color: Colors.black, fontSize: 10.sp, height: 2),
          items: lstOfBottomNavigationBar,
          currentIndex: authNotifier.currentIndex,
          onTap: (getIndex) {
            authNotifier.onIndexChanged(getIndex);
          },
          elevation: 20,
        ),
      ),
    );
  }
}
