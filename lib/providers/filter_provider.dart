import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  // ADDRESS FILTER
  bool _addressFilterBtn1 = false;
  bool get addressFilterBtn1 => _addressFilterBtn1;
  set addressFilterBtn1(bool value) {
    _addressFilterBtn1 = value;
    notifyListeners();
  }

  bool _addressFilterBtn2 = false;
  bool get addressFilterBtn2 => _addressFilterBtn2;
  set addressFilterBtn2(bool value) {
    _addressFilterBtn2 = value;
    notifyListeners();
  }

  bool _addressFilterBtn3 = true;
  bool get addressFilterBtn3 => _addressFilterBtn3;
  set addressFilterBtn3(bool value) {
    _addressFilterBtn3 = value;
    notifyListeners();
  }

  activateAddressFilterBtn1() {
    addressFilterBtn1 = true;
    addressFilterBtn2 = false;
    addressFilterBtn3 = false;
  }

  activateAddressFilterBtn2() {
    addressFilterBtn1 = false;
    addressFilterBtn2 = true;
    addressFilterBtn3 = false;
  }

  activateAddressFilterBtn3() {
    addressFilterBtn1 = false;
    addressFilterBtn2 = false;
    addressFilterBtn3 = true;
  }

  // TIME FILTER
  bool _timeFilterBtn1 = false;
  bool get timeFilterBtn1 => _timeFilterBtn1;
  set timeFilterBtn1(bool value) {
    _timeFilterBtn1 = value;
    notifyListeners();
  }

  bool _timeFilterBtn2 = false;
  bool get timeFilterBtn2 => _timeFilterBtn2;
  set timeFilterBtn2(bool value) {
    _timeFilterBtn2 = value;
    notifyListeners();
  }

  bool _timeFilterBtn3 = true;
  bool get timeFilterBtn3 => _timeFilterBtn3;
  set timeFilterBtn3(bool value) {
    _timeFilterBtn3 = value;
    notifyListeners();
  }

  activateTimeFilterBtn1() {
    timeFilterBtn1 = true;
    timeFilterBtn2 = false;
    timeFilterBtn3 = false;
  }

  activateTimeFilterBtn2() {
    timeFilterBtn1 = false;
    timeFilterBtn2 = true;
    timeFilterBtn3 = false;
  }

  activateTimeFilterBtn3() {
    timeFilterBtn1 = false;
    timeFilterBtn2 = false;
    timeFilterBtn3 = true;
  }

  // RECEIVER ADDRESS FILTER
  bool _receiverAddressFilterBtn1 = false;
  bool get receiverAddressFilterBtn1 => _receiverAddressFilterBtn1;
  set receiverAddressFilterBtn1(bool value) {
    _receiverAddressFilterBtn1 = value;
    notifyListeners();
  }

  bool _receiverAddressFilterBtn2 = false;
  bool get receiverAddressFilterBtn2 => _receiverAddressFilterBtn2;
  set receiverAddressFilterBtn2(bool value) {
    _receiverAddressFilterBtn2 = value;
    notifyListeners();
  }

  bool _receiverAddressFilterBtn3 = true;
  bool get receiverAddressFilterBtn3 => _receiverAddressFilterBtn3;
  set receiverAddressFilterBtn3(bool value) {
    _receiverAddressFilterBtn3 = value;
    notifyListeners();
  }

  activateReceiverAddressFilterBtn1() {
    receiverAddressFilterBtn1 = true;
    receiverAddressFilterBtn2 = false;
    receiverAddressFilterBtn3 = false;
  }

  activateReceiverAddressFilterBtn2() {
    receiverAddressFilterBtn1 = false;
    receiverAddressFilterBtn2 = true;
    receiverAddressFilterBtn3 = false;
  }

  activateReceiverAddressFilterBtn3() {
    receiverAddressFilterBtn1 = false;
    receiverAddressFilterBtn2 = false;
    receiverAddressFilterBtn3 = true;
  }

  // ORDER FILTER
  bool _orderFilterBtn1 = true;
  bool get orderFilterBtn1 => _orderFilterBtn1;
  set orderFilterBtn1(bool value) {
    _orderFilterBtn1 = value;
    notifyListeners();
  }

  bool _orderFilterBtn2 = false;
  bool get orderFilterBtn2 => _orderFilterBtn2;
  set orderFilterBtn2(bool value) {
    _orderFilterBtn2 = value;
    notifyListeners();
  }

  bool _orderFilterBtn3 = false;
  bool get orderFilterBtn3 => _orderFilterBtn3;
  set orderFilterBtn3(bool value) {
    _orderFilterBtn3 = value;
    notifyListeners();
  }

  bool _orderFilterBtn4 = false;
  bool get orderFilterBtn4 => _orderFilterBtn4;
  set orderFilterBtn4(bool value) {
    _orderFilterBtn4 = value;
    notifyListeners();
  }

  activateOrderFilterBtn1() {
    orderFilterBtn1 = true;
    orderFilterBtn2 = false;
    orderFilterBtn3 = false;
    orderFilterBtn4 = false;
  }

  activateOrderFilterBtn2() {
    orderFilterBtn1 = false;
    orderFilterBtn2 = true;
    orderFilterBtn3 = false;
    orderFilterBtn4 = false;
  }

  activateOrderFilterBtn3() {
    orderFilterBtn1 = false;
    orderFilterBtn2 = false;
    orderFilterBtn3 = true;
    orderFilterBtn4 = false;
  }

  activateOrderFilterBtn4() {
    orderFilterBtn1 = false;
    orderFilterBtn2 = false;
    orderFilterBtn3 = false;
    orderFilterBtn4 = true;
  }

  // ORDER STATUS FILTER
  bool _orderStatusFilterBtn1 = true;
  bool get orderStatusFilterBtn1 => _orderStatusFilterBtn1;
  set orderStatusFilterBtn1(bool value) {
    _orderStatusFilterBtn1 = value;
    notifyListeners();
  }

  bool _orderStatusFilterBtn2 = false;
  bool get orderStatusFilterBtn2 => _orderStatusFilterBtn2;
  set orderStatusFilterBtn2(bool value) {
    _orderStatusFilterBtn2 = value;
    notifyListeners();
  }

  bool _orderStatusFilterBtn3 = false;
  bool get orderStatusFilterBtn3 => _orderStatusFilterBtn3;
  set orderStatusFilterBtn3(bool value) {
    _orderStatusFilterBtn3 = value;
    notifyListeners();
  }

  activateOrderStatusFilterBtn1() {
    orderStatusFilterBtn1 = true;
    orderStatusFilterBtn2 = false;
    orderStatusFilterBtn3 = false;
  }

  activateOrderStatusFilterBtn2() {
    orderStatusFilterBtn1 = false;
    orderStatusFilterBtn2 = true;
    orderStatusFilterBtn3 = false;
  }

  activateOrderStatusFilterBtn3() {
    orderStatusFilterBtn1 = false;
    orderStatusFilterBtn2 = false;
    orderStatusFilterBtn3 = true;
  }
}
