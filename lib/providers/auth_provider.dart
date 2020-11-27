import 'dart:convert';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/services/auth_service.dart';
import 'package:hani_almutairi_logistic/services/web_api.dart';
import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  // bool _isLoggedIn = false;
  // bool get isLoggedIn => _isLoggedIn;
  // set isLoggedIn(bool isUserExist) {
  //   _isLoggedIn = isUserExist;
  //   notifyListeners();
  // }

  // // user
  // Map<String, dynamic> _user = {};
  // Map get user => _user;
  // setUser() async {
  //   _user = await _authService.getUser();
  //   isLoggedIn = _user == null ? false : true;
  //   notifyListeners();
  // }

  // checkLoginStatus() async {
  //   return _user = await _authService.getUser();
  // }

  login(context, userCredential) async {
    isLoading = true;
    await _authService.login(userCredential).then((response) {
      if (response['status'] != false) {
        // setUser();
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => OtpScreen()),
        //   (Route<dynamic> route) => false,
        // );
        Navigator.of(context).pushNamed(TabsScreen.routeName);
      } else {
        Flushbar(
          title: "Failed Login",
          message: response['message']['status'].toString(),
          duration: Duration(seconds: 3),
        ).show(context);
      }
    });
    isLoading = false;
  }

  Future<List<SearchCityModel>> getCities(filter) async {
    return await _authService.getCities(filter);
  }

  signUp(context, user) async {
    isLoading = true;
    await _authService.signUpUser(user).then((response) {
      if (response['status'] != false) {
        // setUser();
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        //   (Route<dynamic> route) => false,
        // );
        Navigator.of(context).pushNamed(TabsScreen.routeName);
      } else {
        Flushbar(
          title: "Registration Failed",
          message: response['message']['status'].toString(),
          duration: Duration(seconds: 3),
        ).show(context);
      }
    });
    isLoading = false;
  }

  // logOut(context) async {
  //   await _authService.logoutUser(context);
  //   notifyListeners();
  // }
}
