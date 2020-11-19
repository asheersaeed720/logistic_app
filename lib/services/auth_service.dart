// import 'dart:convert';

// import 'package:hani_almutairi_logistic/screens/auth%20tab%20screen/auth_tab_screen.dart';
// import 'package:hani_almutairi_logistic/services/web_api.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
//   Future<Map> login(String username, String password) async {
//     var result;

//     final loginData = {
//       'username': username,
//       'password': password,
//     };

//     Response response = await post(
//       // WebApi.loginURL,
//       body: loginData,
//       headers: {'APP-KEY': '${WebApi.apiKey}'},
//     );

//     if (response.statusCode == 200) {
//       var responseJson = json.decode(response.body);
//       saveUser(responseJson);
//       result = {'status': true, 'message': 'Successful', 'user': responseJson};
//     } else {
//       result = {
//         'status': false,
//         'message': json.decode(response.body)['status'] == 'Invalid Username' ||
//                 json.decode(response.body)['status'] == 'Invalid Password'
//             ? json.decode(response.body)['status']
//             : json.decode(response.body)['error']
//       };
//     }

//     return result;
//   }

//   Future<Map> signUpUser(name, phone, username, email, password) async {
//     var result;

//     final signUpData = {
//       'name': name,
//       'phone': phone,
//       'username': username,
//       'email': email,
//       'password': password,
//     };

//     Response response = await post(
//       // WebApi.registerURL,
//       body: signUpData,
//       headers: {'APP-KEY': '${WebApi.apiKey}'},
//     );

//     if (response.statusCode == 200) {
//       var responseJson = json.decode(response.body);
//       saveUser(responseJson);
//       result = {'status': true, 'message': 'Successful', 'user': responseJson};
//     } else {
//       result = {
//         'status': false,
//         'message': json.decode(response.body)['status'],
//       };
//     }

//     return result;
//   }

//   saveUser(userData) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setString('userData', jsonEncode(userData));
//     print(preferences.setString('userData', json.encode(userData)));
//   }

//   getUser() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     var userData = preferences.getString('userData');
//     if (userData != null) {
//       Map<String, dynamic> user = json.decode(userData);
//       return user;
//     }
//   }

//   logoutUser(context) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.remove('userData');
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => AuthTabScreen()),
//       (Route<dynamic> route) => false,
//     );
//   }
// }
