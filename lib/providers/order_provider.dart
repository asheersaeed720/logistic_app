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

  String _orderPayer = 'Sender';
  String get orderPayer => _orderPayer;
  set orderPayer(String val) {
    _orderPayer = val;
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
    selectedSenderAddress = selectedValue;
    print(selectedValue);
  }

  clearSenderSelectedRadioBtn() {
    selectedSenderAddress = null;
  }

  clearReceiverSelectedRadioBtn() {
    selectedReceiverAddress = null;
  }

  setSelectedReceiverAddress(String selectedValue) {
    selectedReceiverAddress = selectedValue;
    print(selectedReceiverAddress);
  }

  setSelectedTime(String selectedValue) {
    selectedTime = selectedValue;
    print(selectedTime);
  }

  setOrderPayer(String selectedValue) {
    orderPayer = selectedValue;
    print(orderPayer);
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
    // SENDER DETAILS
    selectedSenderAddressId,
    senderName,
    senderCity,
    senderAddress,
    senderDistrict,
    senderContact,
    // RECEIVER DETAILS
    selectedReceiverAddressId,
    receiverName,
    receiverCity,
    receiverAddress,
    receiverDistrict,
    receiverContact,
    // EXTRA DETAILS
    packageCheckedValue,
    fragileCheckedValue,
    selectedTime,
    collectionCash,
    refNo,
    orderPayer,
    couponCode,
  ) async {
    isLoading = true;
    final response = await _orderService.addUserOrder(
      context,
      user,
      // SENDER DETAILS
      selectedSenderAddressId,
      senderName,
      senderCity,
      senderAddress,
      senderDistrict,
      senderContact,
      // RECEIVER DETAILS
      selectedReceiverAddressId,
      receiverName,
      receiverCity,
      receiverAddress,
      receiverDistrict,
      receiverContact,
      // EXTRA DETAILS
      packageCheckedValue,
      fragileCheckedValue,
      selectedTime,
      collectionCash,
      refNo,
      orderPayer,
      couponCode,
    );

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
          'orderId': response['user']['data']['order_user_id'],
          // SENDER DETAILS
          'senderName': response['user']['data']['order_sender_name'],
          'senderCity': response['user']['data']['order_sender_city'],
          'senderAddress': response['user']['data']['order_sender_address'],
          'senderDistrict': response['user']['data']['order_sender_district'],
          'senderContact': response['user']['data']['order_sender_contact'],
          // RECEIVER DETAILS
          'receiverName': response['user']['data']['order_reciever_name'],
          'receiverCity': response['user']['data']['order_reciever_city'],
          'receiverAddress': response['user']['data']['order_reciever_address'],
          'receiverDistrict': response['user']['data']
              ['order_reciever_district'],
          'receiverContact': response['user']['data']['order_reciever_contact'],
          // EXTRA DETAILS
          'packageCheckedValue': response['user']['data']['order_packaging'],
          'fragileCheckedValue': response['user']['data']['order_fragile'],
          'selectedTime': response['user']['data']['order_pickup_time'],
          'orderPayer': response['user']['data']['order_payer'],
          'refNo': response['user']['data']['order_ref_no'],

          // 'orderId': response['user']['orderid'],
          // 'senderName': response['user']['data']['order_sender_name'],
          // 'senderCity': response['user']['data']['order_sender_city'],
          // 'senderDistrict': response['user']['data']['order_sender_address'],
          // 'senderMobile': response['user']['data']['order_sender_contact'],
          // 'receiverName': response['user']['data']['order_reciever_name'],
          // 'receiverCity': response['user']['data']['order_reciever_city'],
          // 'receiverDistrict': response['user']['data']
          //     ['order_reciever_address'],
          // 'receiverMobile': response['user']['data']['order_reciever_contact'],
          // 'refNo': refNo,
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

  cancelOrder(context, user, orderId, orderStatus) async {
    isLoading = true;
    final response = await _orderService.cancelUserOrder(
        context, user, orderId, orderStatus);

    if (response['status'] == true) {
      Fluttertoast.showToast(
        msg: "Your Order has been Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response['user']['data']);
    } else {
      Flushbar(
        title: "Order Failed",
        message: response['message']['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }

  editOrder(context, user, orderId, editOrderData) async {
    isLoading = true;
    final response = await _orderService.editUserOrder(
        context, user, orderId, editOrderData);

    if (response['status'] == true) {
      Fluttertoast.showToast(
        msg: "Your Order has been Updated",
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
        title: "Order Failed",
        message: response['message']['message'].toString(),
        duration: Duration(seconds: 3),
      ).show(context);
    }

    isLoading = false;
  }

  delUserOrder(test, orderId, user) async {
    isLoading = true;
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
    isLoading = false;
  }
}
