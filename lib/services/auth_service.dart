import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/utils/web_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<List<SearchCityModel>> getCities(filter) async {
    try {
      var response = await Dio().get(
        '${WebApi.getCitiesURL}',
        queryParameters: {"filter": filter},
        options: Options(
          headers: {"APP_KEY": '${WebApi.appKey}'},
        ),
      );

      var models = SearchCityModel.fromJsonList(response.data);
      return models;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map> loginUser(userCredential) async {
    var result;

    final loginData = {
      'phone': userCredential.mobileNo,
      'password': userCredential.password,
    };

    var response = await post(
      WebApi.loginURL,
      body: loginData,
      headers: {'APP_KEY': '${WebApi.appKey}'},
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      saveUser(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }
    return result;
  }

  Future<Map> signUpUser(user) async {
    var result;

    final signUpData = {
      'first_name': '${user.firstname}',
      'last_name': '${user.lastName}',
      'user_mobile': '${user.mobileNo}',
      'user_city_id': '${user.cityId}',
      'user_district': '${user.district}',
      'user_address': '${user.address}',
      'user_password': '${user.password}',
    };

    print(signUpData);

    var response = await post(
      WebApi.registerURL,
      body: signUpData,
      headers: {'APP_KEY': '${WebApi.appKey}'},
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }

    return result;
  }

  Future<Map> getUserVerify(otp, userMobile, userPassword) async {
    var result;

    var response = await post(
      WebApi.userVerificationURL,
      body: {
        'phone': userMobile,
        'password': userPassword,
        'otp': otp,
      },
      headers: {
        'APP_KEY': '${WebApi.appKey}',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      saveUser(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }
    return result;
  }

  saveUser(userData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('userData', jsonEncode(userData));
  }

  getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userData = preferences.getString('userData');
    if (userData != null) {
      Map user = json.decode(userData);
      print(user);
      return user;
    }
  }

  logoutUser(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userData');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future<Map> changeUserPassword(user, oldPasswordVal, passwordVal) async {
    var result;

    var response = await put(
      WebApi.changePasswordURL +
          '/${user['user_id']}?password=$passwordVal&oldpassword=$oldPasswordVal',
      headers: {
        'APP_KEY': '${WebApi.appKey}',
        'x-api-key': '${user['token']}',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'].toString(),
      };
      print(json.decode(response.body));
    }
    return result;
  }

  Future<Map> forgotUserPassword(userCredential) async {
    var result;

    var response = await post(
      WebApi.getforgotPasswordKeyURL,
      body: {'phone': userCredential.mobileNo},
      headers: {
        'APP_KEY': '${WebApi.appKey}',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'].toString(),
      };
      print(json.decode(response.body));
    }
    return result;
  }

  Future<Map> getForgotUserPasswordVerify(password, key) async {
    var result;

    var response = await post(
      WebApi.forgotPasswordURL,
      body: {
        'key': '$key',
        'newpassword': '$password',
      },
      headers: {
        'APP_KEY': '${WebApi.appKey}',
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'].toString(),
      };
      print(json.decode(response.body));
    }
    return result;
  }
}
