import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';

import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/services/web_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<List<SearchCityModel>> getCities(filter) async {
    try {
      var response = await Dio().get(
        '${WebApi.getCitiesURL}',
        queryParameters: {"filter": filter},
        options: Options(
          headers: {"APP_KEY": '${WebApi.apiKey}'},
        ),
      );

      var models = SearchCityModel.fromJsonList(response.data);
      return models;
    } catch (e) {
      throw (e);
    }
  }

  Future<Map> getUserOtp(userCredential) async {
    var result;

    final loginData = {
      'phone': userCredential.mobileNo,
      'password': userCredential.password,
    };

    var response = await post(
      WebApi.loginGetkeyURL,
      body: loginData,
      headers: {'APP_KEY': '${WebApi.apiKey}'},
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

  Future<Map> loginUser(userCredential, key) async {
    var result;

    final loginData = {
      'phone': userCredential.mobileNo,
      'password': userCredential.password,
      'key': key,
    };

    // print('Before hit: $loginData');

    var response = await post(
      WebApi.loginURL,
      body: loginData,
      headers: {'APP_KEY': '${WebApi.apiKey}'},
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
      // 'user_email': '${user.email}',
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
      headers: {'APP_KEY': '${WebApi.apiKey}'},
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
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
        'APP_KEY': '${WebApi.apiKey}',
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
        'message': json.decode(response.body).toString(),
      };
      print(json.decode(response.body));
    }
    return result;
  }

  Future<Map> getUserForgotPasswordKey(userCredential) async {
    var result;

    var response = await post(
      WebApi.getforgotPasswordKeyURL,
      body: {'email': userCredential.email},
      headers: {
        'APP_KEY': '${WebApi.apiKey}',
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

  Future<Map> userForgotPassword(password, key) async {
    var result;

    var response = await post(
      WebApi.forgotPasswordURL,
      body: {
        'key': '$key',
        'newpassword': '$password',
      },
      headers: {
        'APP_KEY': '${WebApi.apiKey}',
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
