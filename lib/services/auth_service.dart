import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/services/web_api.dart';

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

  Future<Map> login(userCredential) async {
    var result;

    final loginData = {
      'email': userCredential.email,
      'password': userCredential.password,
    };

    print(loginData);

    var response = await post(
      WebApi.loginURL,
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
      print(result);
    }
    return result;
  }

  Future<Map> signUpUser(user) async {
    var result;

    final signUpData = {
      'first_name': user.firstname,
      'last_name': user.lastName,
      'user_email': user.email,
      'user_mobile': user.mobileNo,
      'user_city_id': user.cityId.toString(),
      'user_district': user.district,
      'user_password': user.password,
    };

    // final signUpData = {
    //   'first_name': 'Tester',
    //   'last_name': 'Ultra',
    //   'user_mobile': '1234656',
    //   'user_city_id': '37420',
    //   'user_district': 'Test chorangi',
    //   'user_password': 'google1234',
    // };
    // print('Body Before hit: $signUpData');

    var response = await post(
      WebApi.registerURL,
      body: signUpData,
      headers: {'APP_KEY': '${WebApi.apiKey}'},
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      // saveUser(responseJson);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
      print(result);
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
      print(result);
    }

    return result;
  }

  // saveUser(userData) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('userData', jsonEncode(userData));
  //   print(preferences.setString('userData', json.encode(userData)));
  // }

  // getUser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var userData = preferences.getString('userData');
  //   if (userData != null) {
  //     Map<String, dynamic> user = json.decode(userData);
  //     return user;
  //   }
  // }

  // logoutUser(context) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.remove('userData');
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => AuthTabScreen()),
  //     (Route<dynamic> route) => false,
  //   );
  // }
}
