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

  // String _selectedSenderAddress;
  // String get selectedSenderAddress => _selectedSenderAddress;
  // set selectedSenderAddress(String val) {
  //   _selectedSenderAddress = val;
  //   notifyListeners();
  // }

  List _selectedSenderAddress;
  List get selectedSenderAddress => _selectedSenderAddress;
  set selectedSenderAddress(List val) {
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

  setSelectedSenderAddress(selectedValue) {
    // Map valueMap = jsonDecode(selectedValue);
    // // var ab = json.decode('[$selectedValue]');
    // // print(ab[1]);
    // // selectedSenderAddress = ab;
    print(selectedValue);
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
      couponCode) async {
    isLoading = true;
    final response = await _orderService.addUserOrder(
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
        couponCode);

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
      print(response['user']['data']);
      Navigator.of(context).pushReplacementNamed(
        OrderSuccess.routeName,
        arguments: {
          'orderId': response['user']['orderid'],
          'senderName': response['user']['data']['order_sender_name'],
          'senderCity': response['user']['data']['order_sender_city'],
          'senderDistrict': response['user']['data']['order_sender_address'],
          'senderMobile': response['user']['data']['order_sender_contact'],
          'receiverName': response['user']['data']['order_reciever_name'],
          'receiverCity': response['user']['data']['order_reciever_city'],
          'receiverDistrict': response['user']['data']
              ['order_reciever_address'],
          'receiverMobile': response['user']['data']['order_reciever_contact'],
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

    isLoading = false;
  }

  Future<List<Order>> getUserOrder(user) async {
    try {
      var response = await get(
        // '${WebApi.getOrderURL}/$userId',
        '${WebApi.getOrderURL}',
        headers: {
          'APP-KEY': WebApi.apiKey,
          // 'x-api-key': user['token'],
          'x-api-key': 'f51adea8f02ca1a66033a443b4574b15'
        },
      );
      var responseJson = json.decode(response.body);
      print(responseJson);
      return (responseJson as List).map((i) => Order.fromJson(i)).toList();
    } catch (e) {
      throw (e);
    }
  }

  Future<List<Order>> getFilterUserOrder(user, String orderStatus) async {
    try {
      var response = await get(
        // '${WebApi.getOrderURL}/$userId',
        '${WebApi.getFilterOrdersURL}/?type=$orderStatus',
        headers: {
          'APP-KEY': WebApi.apiKey,
          'x-api-key': user['token'],
        },
      );
      var responseJson = json.decode(response.body);
      print(responseJson);
      return (responseJson as List).map((i) => Order.fromJson(i)).toList();
    } catch (e) {
      throw (e);
    }
  }

  delUserOrder(
    String orderId,
    user,
  ) async {
    try {
      delete(
        '${WebApi.addOrderURL}/$orderId',
        headers: {
          'APP-KEY': WebApi.apiKey,
          'x-api-key': user['token'],
        },
      );
    } catch (e) {
      throw (e);
    }
  }
}
