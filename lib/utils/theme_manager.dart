import 'color_const.dart';

class ThemeManager {
  static final ThemeManager _singleton = ThemeManager._internal();

  factory ThemeManager() {
    return _singleton;
  }

  ThemeManager._internal();

  bool isDark = false;

  bool isDarkTheme() {
    return isDark;
  }

  void setDarkTheme(bool value) {
    isDark = value;
  }

  get getWhiteColor => whiteColor;

  get getBlackColor => secondBlackColor;

  get getTransparentColor => transparentColor;
  get getGreyColor => greyColor;
  get getDividerColor => dividerColor;
  get getGreenColor => greenColor;
}
