import 'dart:developer';

import 'package:e_commerce/shared_preference/sharedPreference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../service/service.dart';
import '../widget/scaffold_snackbar.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class AuthNotifer extends ChangeNotifier {
  int currentIndex = 0;
  onIndexChanged(index) {
    currentIndex = index;
    notifyListeners();
  }

  isObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool obscureText = true;

  bool isConnected = false;
  bool isLoading = false;

  ///------------- sign in --------------

  Future signInWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      await BaseService().checkConnection();
      final User user = (await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      ))
          .user!;
      if (user.email != null) {
        Navigator.pushReplacementNamed(context, Routes.bottomNavigationBar);
        PrefServices().setIsUserLoggedIn(true);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print(e.toString());
      ScaffoldSnackbar.of(context).show(e.toString());
    }
    notifyListeners();
  }

  ///------------- sign up --------------
  Future signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      isConnected = await BaseService().checkConnection();
    } catch (e) {
      isLoading = false;
      ScaffoldSnackbar.of(context).show(e.toString());
    } finally {}
    if (isConnected == true) {
      try {
        final User? user = (await auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        ))
            .user;

        if (user != null) {
          isLoading = false;
          PrefServices().setIsUserLoggedIn(true);
          Navigator.pushReplacementNamed(context, Routes.bottomNavigationBar);
        }
        isLoading = false;
        notifyListeners();
      } catch (e) {
        isLoading = false;

        print(e);
        ScaffoldSnackbar.of(context).show(e.toString());

        Navigator.pushReplacementNamed(context, Routes.login);
      }
    } else {
      ScaffoldSnackbar.of(context).show("Turn on the data and retry again");
    }
    isLoading = false;
    notifyListeners();
  }

  signOut(BuildContext context) async {
    await auth.signOut();
    PrefServices().clearData();
    Navigator.pushReplacementNamed(context, Routes.login);
  }
}
