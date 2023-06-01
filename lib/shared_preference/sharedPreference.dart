import 'package:shared_preferences/shared_preferences.dart';

class PrefServices {
  static final PrefServices _singleton = PrefServices._internal();

  factory PrefServices() {
    return _singleton;
  }

  PrefServices._internal();

  late SharedPreferences prefs;

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void setIsUserLoggedIn(bool isLoggedIn) async {
    await prefs.setBool("isLoggedIn", isLoggedIn);
  }

  bool getIsUserLoggedIn() {
    return prefs.getBool("isLoggedIn") ?? false;
  }
 void setCartData(String cartData) async {
    await prefs.setString("cartData", cartData);
  }

  String getCartData() {
    return prefs.getString("cartData") ?? "";
  }
 

  
  void clearData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }


}
