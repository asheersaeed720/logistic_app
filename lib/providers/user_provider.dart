import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hani_almutairi_logistic/models/balance.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'package:hani_almutairi_logistic/models/notification.dart';

import 'package:flushbar/flushbar.dart';

import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/services/user_service.dart';
import 'package:hani_almutairi_logistic/utils/web_api.dart';
import 'package:hani_almutairi_logistic/models/notification.dart';

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

  Future<List<Balance>> getbalance(user) {
    return _userService.getUserbalance(user);
  }

  Future<List<NotificationMessage>> getNotification(user) {
    return _userService.getUserNotification(user);
  }

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

  banktransfer(context, user, bankName, accountNo, ownerName) async {
    isLoading = true;
    final response =
        await _userService.banktransfer(user, bankName, accountNo, ownerName);

    if (response['status'] == true) {
      Fluttertoast.showToast(
        msg: "Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
