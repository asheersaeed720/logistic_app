import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hani_almutairi_logistic/models/delivery_cost.dart';
import 'package:http/http.dart';

import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';

import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/screens/order/order_success_screen.dart';
import 'package:hani_almutairi_logistic/services/order_service.dart';
import 'package:hani_almutairi_logistic/utils/web_api.dart';

class OrderProvider with ChangeNotifier {
  OrderService _orderService = OrderService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  // bool _isSearchOrderVisible = false;
  // bool get isSearchOrderVisible => _isSearchOrderVisible;
  // set isSearchOrderVisible(bool value) {
  //   _isSearchOrderVisible = value;
  //   notifyListeners();
  // }

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

  // TODAY PICKUP TIME
  String _selectedTime = 'From 9 to 12 Today';
  String get selectedTime => _selectedTime;
  set selectedTime(String val) {
    _selectedTime = val;
    notifyListeners();
  }

  setSelectedTime(String selectedValue) {
    selectedTime = selectedValue;
    print(selectedTime);
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

  setSelectedReceiverAddress(String selectedValue) {
    selectedReceiverAddress = selectedValue;
    print(selectedReceiverAddress);
  }

  clearReceiverSelectedRadioBtn() {
    selectedReceiverAddress = null;
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

  // SAVE SENDER ADDRESS FOR FUTURE USE
  bool _isSenderAddressSave = false;
  bool get isSenderAddressSave => _isSenderAddressSave;
  set isSenderAddressSave(bool value) {
    _isSenderAddressSave = value;
    notifyListeners();
  }

  setSenderAddressChecked(bool checkedVal) {
    isSenderAddressSave = checkedVal;
    print(isSenderAddressSave);
  }

  // SAVE RECEIVER ADDRESS FOR FUTURE USE
  bool _isReceiverAddressSave = false;
  bool get isReceiverAddressSave => _isReceiverAddressSave;
  set isReceiverAddressSave(bool value) {
    _isReceiverAddressSave = value;
    notifyListeners();
  }

  setReceiverAddressChecked(bool checkedVal) {
    isReceiverAddressSave = checkedVal;
    print(isReceiverAddressSave);
  }

  Future<Map> getDeliveryCost(user) {
    return _orderService.getDeliveryCost(user);
  }

  double _deliveryAmount;
  double get deliveryAmount => _deliveryAmount;
  set deliveryAmount(double value) {
    _deliveryAmount = value;
    notifyListeners();
  }

  double calculateDeliveryCost(deliveryCost) {
    deliveryAmount = double.parse(deliveryCost);
    return deliveryAmount;
  }

  // // ADD ORDER
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
    isSenderAddressSave,
    isReceiverAddressSave,
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
      isSenderAddressSave,
      isReceiverAddressSave,
      orderPayer,
      couponCode,
    );

    if (response['status'] == true) {
      Fluttertoast.showToast(
        msg: "Your Order has been Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response['user']['data']);
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => OrderSuccess(
      //             orderId: response['user']['data']['order_user_id'],
      //             // SENDER DETAILS
      //             senderName: response['user']['data']['order_sender_name'],
      //             senderCity: response['user']['data']['order_sender_city'],
      //             senderAddress: response['user']['data']
      //                 ['order_sender_address'],
      //             senderDistrict: response['user']['data']
      //                 ['order_sender_district'],
      //             senderContact: response['user']['data']
      //                 ['order_sender_contact'],
      //             // RECEIVER DETAILS
      //             receiverName: response['user']['data']['order_reciever_name'],
      //             receiverCity: response['user']['data']['order_reciever_city'],
      //             receiverAddress: response['user']['data']
      //                 ['order_reciever_address'],
      //             receiverDistrict: response['user']['data']
      //                 ['order_reciever_district'],
      //             receiverContact: response['user']['data']
      //                 ['order_reciever_contact'],
      //             // EXTRA DETAILS
      //             collectionCash: response['user']['data']
      //                 ['order_collection_cash'],
      //             packageCheckedValue: response['user']['data']
      //                 ['order_packaging'],
      //             fragileCheckedValue: response['user']['data']
      //                 ['order_fragile'],
      //             selectedTime: response['user']['data']['order_pickup_time'],
      //             orderPayer: response['user']['data']['order_payer'],
      //             refNo: response['user']['data']['order_ref_no'],
      //           )),
      //   (Route<dynamic> route) => false,
      // );
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
          'order_collection_cash': response['user']['data']
              ['order_collection_cash'],
          'packageCheckedValue': response['user']['data']['order_packaging'],
          'fragileCheckedValue': response['user']['data']['order_fragile'],
          'selectedTime': response['user']['data']['order_pickup_time'],
          'orderPayer': response['user']['data']['order_payer'],
          'refNo': response['user']['data']['order_ref_no'],
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

  int _stepOrderFormNumber = 1;
  int get stepOrderFormNumber => _stepOrderFormNumber;
  set stepOrderFormNumber(int value) {
    _stepOrderFormNumber = value;
    notifyListeners();
  }

  // String _senderDefaultAddressNotFound = '';
  // String get senderDefaultAddressNotFound => _senderDefaultAddressNotFound;
  // set senderDefaultAddressNotFound(String value) {
  //   _senderDefaultAddressNotFound = value;
  //   notifyListeners();
  // }

  // String _receiverDefaultAddressNotFound = '';
  // String get receiverDefaultAddressNotFound => _receiverDefaultAddressNotFound;
  // set receiverDefaultAddressNotFound(String value) {
  //   _receiverDefaultAddressNotFound = value;
  //   notifyListeners();
  // }

  // resetSenderDefaultAddressNotFound() {
  //   senderDefaultAddressNotFound = '';
  // }

  // resetReceiverDefaultAddressNotFound() {
  //   receiverDefaultAddressNotFound = '';
  //   notifyListeners();
  // }

  formNavigation() {
    if (stepOrderFormNumber == 1)
      stepOrderFormNumber = 2;
    else
      stepOrderFormNumber = 1;
  }

  resetFormNavigation() {
    stepOrderFormNumber = 1;
  }

  // ADD ORDER
  // addOrderTest(
  //   context,
  //   user,
  //   addOrderData,
  //   isSenderAddressSave,
  //   isReceiverAddressSave,
  //   packageCheckedValue,
  //   fragileCheckedValue,
  //   selectedTime,
  //   orderPayer,
  // ) async {
  //   isLoading = true;
  //   final response = await _orderService.addUserOrderTest(
  //     context,
  //     user,
  //     addOrderData,
  //     isSenderAddressSave,
  //     isReceiverAddressSave,
  //     packageCheckedValue,
  //     fragileCheckedValue,
  //     selectedTime,
  //     orderPayer,
  //   );

  //   if (response['status'] == true) {
  //     Fluttertoast.showToast(
  //       msg: "Your Order has been Added",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.black87,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //     print(response['user']['data']);
  //     Navigator.of(context).pushReplacementNamed(
  //       OrderSuccess.routeName,
  //       arguments: {
  //         'orderId': response['user']['data']['order_user_id'],
  //         // SENDER DETAILS
  //         'senderName': response['user']['data']['order_sender_name'],
  //         'senderCity': response['user']['data']['order_sender_city'],
  //         'senderAddress': response['user']['data']['order_sender_address'],
  //         'senderDistrict': response['user']['data']['order_sender_district'],
  //         'senderContact': response['user']['data']['order_sender_contact'],
  //         // RECEIVER DETAILS
  //         'receiverName': response['user']['data']['order_reciever_name'],
  //         'receiverCity': response['user']['data']['order_reciever_city'],
  //         'receiverAddress': response['user']['data']['order_reciever_address'],
  //         'receiverDistrict': response['user']['data']
  //             ['order_reciever_district'],
  //         'receiverContact': response['user']['data']['order_reciever_contact'],
  //         // EXTRA DETAILS
  //         'packageCheckedValue': response['user']['data']['order_packaging'],
  //         'fragileCheckedValue': response['user']['data']['order_fragile'],
  //         'selectedTime': response['user']['data']['order_pickup_time'],
  //         'orderPayer': response['user']['data']['order_payer'],
  //         'refNo': response['user']['data']['order_ref_no'],
  //       },
  //     );
  //   } else {
  //     Flushbar(
  //       title: "Order Failed",
  //       message: response['message']['message'].toString(),
  //       duration: Duration(seconds: 3),
  //     ).show(context);
  //   }

  //   isLoading = false;
  // }

  Future<List<Order>> getOrders(user) {
    return _orderService.getUserOrder(user);
  }

  Future<List<Order>> getOrdersAsSenderOrReceiver(
      user, receiverORSender, orderStatus) {
    return _orderService.getUserOrderAsSenderOrReceiver(
        user, receiverORSender, orderStatus);
  }

  Future<List<Order>> getFilterOrder(user, receiverORSender) {
    return _orderService.getFilterUserOrder(user, receiverORSender);
  }

  Future<List<Order>> getSearchOrderByMobile(
      context, user, mobileNo, trackingNo) {
    // isSearchOrderVisible = true;
    return _orderService.getSearchUserOrderByMobile(
        context, user, mobileNo, trackingNo);
  }

  Future<List<Order>> getSearch(user, mobileNo, trackingNo) {
    // isSearchOrderVisible = true;
    return _orderService.getSearch(user, mobileNo, trackingNo);
  }

  cancelOrder(context, user, orderId, orderStatus) async {
    isLoading = true;
    final response = await _orderService.cancelUserOrder(
        context, user, orderId, orderStatus);

    if (response['status'] == true) {
      Fluttertoast.showToast(
        msg: "Your Order has been Canceled",
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

  delUserOrder(orderId, user) async {
    isLoading = true;
    try {
      delete(
        '${WebApi.addOrderURL}/$orderId',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );
    } catch (e) {
      throw (e);
    }
    isLoading = false;
  }
}
