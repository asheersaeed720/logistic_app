import 'dart:convert';
import 'package:async/async.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'package:flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/services/user_service.dart';
import 'package:hani_almutairi_logistic/utils/web_api.dart';

class UserProvider with ChangeNotifier {
  UserService _userService = UserService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  addSenderAddress(context, senderAddress, user) async {
    isLoading = true;
    final response =
        await _userService.addUserSenderAddress(context, senderAddress, user);

    if (response['status'] == true) {
      Fluttertoast.showToast(
        msg: "Your address has been Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response['user']);
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
      getSenderAddresses(user);
      Fluttertoast.showToast(
        msg: "Receiver address has been Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response['user']);
    } else {
      Flushbar(
        title: "Failed",
        message: response['message']['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }

  Future<List<UserAddress>> getSenderAddresses(user) {
    return _userService.getSenderAddresses(user);
  }

  Future<List<UserAddress>> getReceiverAddresses(user) {
    return _userService.getReceiverAddresses(user);
  }

  Future<List<UserAddress>> getUserAddressById(user, addressId) {
    return _userService.getUserAddressById(user, addressId);
  }

  // delUserAddress(String addressId, user) {
  //   isLoading = true;
  //   try {
  //     delete(
  //       '${WebApi.delUserAddressesURL}/$addressId',
  //       headers: {
  //         'APP-KEY': WebApi.appKey,
  //         'x-api-key': user['token'],
  //       },
  //     );
  //   } catch (e) {
  //     throw (e);
  //   }
  //   isLoading = false;
  // }

  delUserAddress(context, String addressId, user) async {
    isLoading = true;

    final response = await _userService.delUserAddress(addressId, user);

    if (response['status'] == true) {
      // getSenderAddresses(user);
      Fluttertoast.showToast(
        msg: "Address has been deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response);
    } else {
      Flushbar(
        title: "Failed",
        message: response['message']['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }
}
