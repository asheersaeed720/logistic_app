import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hani_almutairi_logistic/models/search_bank.dart';

import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/screens/reset_password.dart';
import 'package:hani_almutairi_logistic/screens/user_verification_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool isUserExist) {
    _isLoggedIn = isUserExist;
    notifyListeners();
  }

  Map _user = {};
  Map get user => _user;
  setUser() async {
    _user = await _authService.getUser();
    isLoggedIn = _user == null ? false : true;
    notifyListeners();
  }

  checkLoginStatus() async {
    return _user = await _authService.getUser();
  }

  Future<List<SearchCityModel>> getCities(filter) async {
    return await _authService.getCities(filter);
  }

  Future<List<SearchBankModel>> getBanks(filter, user) async {
    return await _authService.getBanks(filter, user);
  }

  login(context, userCredential) async {
    isLoading = true;
    final response = await _authService.loginUser(userCredential);

    if (response['status'] != false) {
      // Timer(
      //     Duration(seconds: 5),
      //     () => Flushbar(
      //           title: "Failed Login",
      //           message: 'Timeout',
      //           duration: Duration(seconds: 3),
      //         ).show(context));
      setUser();
      Phoenix.rebirth(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TabsScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Flushbar(
        title: "Failed Login",
        message: response['message']['status'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }

  signUp(context, user) async {
    isLoading = true;
    var response = await _authService.signUpUser(user);
    if (response['status'] != false) {
      Navigator.of(context).pushNamed(
        UserVerificationScreen.routeName,
        arguments: {
          'firstName': user.firstname,
          'lastName': user.lastName,
          'userMobile': user.mobileNo,
          'userCityId': user.cityId,
          'userDistrict': user.district,
          'userAddress': user.address,
          'userPassword': user.password,
        },
      );
    } else {
      Flushbar(
        title: "Registration Failed",
        message: response['message']['status'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }
    isLoading = false;
  }

  getVerify(context, userMobile, userPassword, otp) async {
    isLoading = true;
    final response =
        await _authService.getUserVerify(otp, userMobile, userPassword);

    if (response['status'] != false) {
      setUser();
      Phoenix.rebirth(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TabsScreen()),
        (Route<dynamic> route) => false,
      );
      Fluttertoast.showToast(
        msg: "You have been Registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Flushbar(
        title: "Registration Failed",
        message: response['message']['status'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }
    isLoading = false;
  }

  logOut(context) async {
    await _authService.logoutUser(context);
    notifyListeners();
  }

  changePassword(context, user, oldPasswordVal, passwordVal) async {
    isLoading = true;
    final response = await _authService.changeUserPassword(
        user, oldPasswordVal, passwordVal);

    if (response['status'] != false) {
      Fluttertoast.showToast(
        msg: "Password successfully changed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.of(context).pop();
    } else {
      Flushbar(
        title: "Password Failed",
        message: response['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }

  forgotPassword(context, userCredential) async {
    isLoading = true;
    final response = await _authService.forgotUserPassword(userCredential);

    if (response['status'] != false) {
      Navigator.of(context).pushNamed(
        ResetPasswordScreen.routeName,
        arguments: userCredential,
      );
    } else {
      Flushbar(
        title: "Forgot password Failed",
        message: response['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }
    isLoading = false;
  }

  getForgotPasswordVerify(context, password, key) async {
    isLoading = true;
    final response =
        await _authService.getForgotUserPasswordVerify(password, key);

    if (response['status'] != false) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
      Fluttertoast.showToast(
        msg: "Password successfully updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Flushbar(
        title: "Password Failed",
        message: response['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }
    isLoading = false;
  }
}
