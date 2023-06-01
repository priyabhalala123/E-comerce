import 'package:e_commerce/provider/auth_notifier.dart';
import 'package:e_commerce/provider/home_notifier.dart';
import 'package:e_commerce/screen/auth/login_screen.dart';
import 'package:e_commerce/screen/auth/signup_screen.dart';
import 'package:e_commerce/screen/splash/splash_screen.dart';
import 'package:e_commerce/shared_preference/sharedPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'screen/bottomNavigationBar/bottom_navigationBar_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefServices().init();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(
        MyApp(),
      ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthNotifer()),
        ChangeNotifierProvider(create: (_) => HomeNotifier()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          routes: routes,
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.splash: (BuildContext context) => SplashScreen(),
    Routes.login: (BuildContext context) => LoginScreen(),
    Routes.signUp: (BuildContext context) => SignUpScreen(),
    Routes.bottomNavigationBar: (BuildContext context) =>
        BottomNavigationBarScreen(
          index: 0,
        )
  };
}

class Routes {
  static const splash = "/";
  static const login = "auth/login_screen.dart";
  static const signUp = "auth/signup_screen.dart";
  static const bottomNavigationBar =
      "bottomNavigationBar/bottom_navigationBar_screen.dart";
}
