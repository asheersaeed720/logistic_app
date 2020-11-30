import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/screens/order/order_success_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_screen.dart';
import 'package:hani_almutairi_logistic/services/order_service.dart';

import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/services/web_api.dart';
import 'package:http/http.dart';

class OrderProvider with ChangeNotifier {
  OrderService _orderService = OrderService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  String _selectedSenderAddress;
  String get selectedSenderAddress => _selectedSenderAddress;
  set selectedSenderAddress(String val) {
    _selectedSenderAddress = val;
    notifyListeners();
  }

  String _selectedReceiverAddress;
  String get selectedReceiverAddress => _selectedReceiverAddress;
  set selectedReceiverAddress(String val) {
    _selectedReceiverAddress = val;
    notifyListeners();
  }

  String _selectedTime = 'From 9 to 12';
  String get selectedTime => _selectedTime;
  set selectedTime(String val) {
    _selectedTime = val;
    notifyListeners();
  }

  String _selectedPay = 'Sender';
  String get selectedPay => _selectedPay;
  set selectedPay(String val) {
    _selectedPay = val;
    notifyListeners();
  }

  bool _packageCheckedValue = false;
  bool get packageCheckedValue => _packageCheckedValue;
  set packageCheckedValue(bool value) {
    _packageCheckedValue = value;
    notifyListeners();
  }

  bool _fragileCheckedValue = false;
  bool get fragileCheckedValue => _fragileCheckedValue;
  set fragileCheckedValue(bool value) {
    _fragileCheckedValue = value;
    notifyListeners();
  }

  setSelectedSenderAddress(String selectedValue) {
    selectedSenderAddress = selectedValue;
    print(selectedSenderAddress);
  }

  setSelectedReceiverAddress(String selectedValue) {
    selectedReceiverAddress = selectedValue;
    print(selectedReceiverAddress);
  }

  setSelectedTime(String selectedValue) {
    selectedTime = selectedValue;
    print(selectedTime);
  }

  setSelectedPay(String selectedValue) {
    selectedPay = selectedValue;
    print(selectedPay);
  }

  setpackageCheckedVal(bool checkedVal) {
    packageCheckedValue = checkedVal;
    print(packageCheckedValue);
  }

  setFragileCheckedVal(bool checkedVal) {
    fragileCheckedValue = checkedVal;
    print(fragileCheckedValue);
  }

  addOrder(
    context,
    user,
    senderName,
    senderCity,
    senderDistrict,
    senderMobile,
    receiverName,
    receiverCity,
    receiverDistrict,
    receiverMobile,
    collectionCashFromReceiver,
    refNo,
    packageCheckedValue,
    fragileCheckedValue,
    selectedTime,
    whoWillPlay,
  ) async {
    isLoading = true;
    await _orderService
        .addUserOrder(
      context,
      user,
      senderName,
      senderCity,
      senderDistrict,
      senderMobile,
      receiverName,
      receiverCity,
      receiverDistrict,
      receiverMobile,
      collectionCashFromReceiver,
      refNo,
      packageCheckedValue,
      fragileCheckedValue,
      selectedTime,
      whoWillPlay,
    )
        .then((response) {
      if (response['status'] == true) {
        Fluttertoast.showToast(
          msg: "Your Order has been Placed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pushReplacementNamed(
          OrderSuccess.routeName,
          arguments: {
            'orderId': response['user']['orderid'],
            'senderName': senderName,
            'senderCity': senderCity,
            'senderDistrict': senderDistrict,
            'senderMobile': senderMobile,
            'receiverName': receiverName,
            'receiverCity': receiverCity,
            'receiverDistrict': receiverDistrict,
            'receiverMobile': receiverMobile,
            'refNo': refNo,
          },
        );
      } else {
        Flushbar(
          title: "Order Failed",
          message: response['message']['message'].toString(),
          duration: Duration(seconds: 3),
        ).show(context);
      }
    });
    isLoading = false;
  }

  Future<List<Order>> getUserOrder(userId) async {
    try {
      var response = await get(
        '${WebApi.getOrderURL}/$userId',
        headers: {
          'APP-KEY': WebApi.apiKey,
          'x-api-key': WebApi.xApiKey,
        },
      );
      var responseJson = json.decode(response.body);
      print(responseJson);
      return (responseJson as List).map((i) => Order.fromJson(i)).toList();
    } catch (e) {
      throw (e);
    }
  }

  delUserOrder(String orderId, userId) async {
    isLoading = true;
    try {
      delete(
        '${WebApi.addOrderURL}/$orderId',
        headers: {
          'APP-KEY': WebApi.apiKey,
          'x-api-key': WebApi.xApiKey,
        },
      ).then((value) {
        getUserOrder(userId);
      });
    } catch (e) {
      throw (e);
    }
    isLoading = false;
  }
}
