import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
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
    notifyListeners();
  }

  activateAddressFilterBtn2() {
    addressFilterBtn1 = false;
    addressFilterBtn2 = true;
    addressFilterBtn3 = false;
    notifyListeners();
  }

  activateAddressFilterBtn3() {
    addressFilterBtn1 = false;
    addressFilterBtn2 = false;
    addressFilterBtn3 = true;
    notifyListeners();
  }

  // FILTER 2
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
    notifyListeners();
  }

  activateTimeFilterBtn2() {
    timeFilterBtn1 = false;
    timeFilterBtn2 = true;
    timeFilterBtn3 = false;
    notifyListeners();
  }

  activateTimeFilterBtn3() {
    timeFilterBtn1 = false;
    timeFilterBtn2 = false;
    timeFilterBtn3 = true;
    notifyListeners();
  }

  // FILTER 3
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
    notifyListeners();
  }

  activateReceiverAddressFilterBtn2() {
    receiverAddressFilterBtn1 = false;
    receiverAddressFilterBtn2 = true;
    receiverAddressFilterBtn3 = false;
    notifyListeners();
  }

  activateReceiverAddressFilterBtn3() {
    receiverAddressFilterBtn1 = false;
    receiverAddressFilterBtn2 = false;
    receiverAddressFilterBtn3 = true;
    notifyListeners();
  }
}
