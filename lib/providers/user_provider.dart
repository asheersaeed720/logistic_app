import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/services/user_service.dart';
import 'package:hani_almutairi_logistic/services/web_api.dart';
import 'package:http/http.dart';

class UserProvider with ChangeNotifier {
  UserService _userService = UserService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  Future<List<UserAddress>> getSenderAddresses(user) async {
    try {
      var response = await get(
        '${WebApi.getUserAddressesURL}/${user['user_id']}',
        headers: {
          'APP_KEY': '${WebApi.apiKey}',
          'x-api-key': '${user['token']}',
        },
      );
      var responseJson = json.decode(response.body);
      return (responseJson['sender'] as List)
          .map((i) => UserAddress.fromJson(i))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  Future<List<UserAddress>> getReceiverAddresses(user) async {
    try {
      var response = await get(
        '${WebApi.getUserAddressesURL}/${user['user_id']}',
        headers: {
          'APP_KEY': '${WebApi.apiKey}',
          'x-api-key': '${user['token']}',
        },
      );
      var responseJson = json.decode(response.body);
      return (responseJson['reciever'] as List)
          .map((i) => UserAddress.fromJson(i))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  Future<List<UserAddress>> getUserAddressById(user, id) async {
    try {
      var response = await get(
        '${WebApi.getUserAddressesByIdURL}/$id',
        headers: {
          'APP_KEY': '${WebApi.apiKey}',
          'x-api-key': '${user['token']}',
        },
      );
      var responseJson = json.decode(response.body);
      print(responseJson);
      return (responseJson as List)
          .map((i) => UserAddress.fromJson(i))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  addSenderAddress(context, senderAddress, user) async {
    isLoading = true;
    final response =
        await _userService.addUserSenderAddress(context, senderAddress, user);

    if (response['status'] == true) {
      // Fluttertoast.showToast(
      //   msg: "Your address has been Added",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.black87,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
      print(response['user']);
      // Navigator.of(context).pushReplacementNamed(OrderSuccess.routeName);
    } else {
      Flushbar(
        title: "Failed",
        message: response['message']['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }

  addReceiverAddress(context, receiverAddress, user) async {
    isLoading = true;
    final response = await _userService.addUserReceiverAddress(
        context, receiverAddress, user);

    if (response['status'] == true) {
      // Fluttertoast.showToast(
      //   msg: "Receiver address has been Added",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.black87,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
      print(response['user']);
      // Navigator.of(context).pushReplacementNamed(OrderSuccess.routeName);
    } else {
      Flushbar(
        title: "Failed",
        message: response['message']['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }

  delUserAddress(String userId, user) async {
    isLoading = true;
    try {
      delete(
        '${WebApi.delUserAddressesURL}/$userId',
        headers: {
          'APP-KEY': WebApi.apiKey,
          'x-api-key': user['token'],
        },
      );
    } catch (e) {
      throw (e);
    }
    isLoading = false;
  }
}
