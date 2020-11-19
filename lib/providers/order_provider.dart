import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  bool _activeFilterBtn1 = false;
  bool get activeFilterBtn1 => _activeFilterBtn1;
  set activeFilterBtn1(bool value) {
    _activeFilterBtn1 = value;
    notifyListeners();
  }

  bool _activeFilterBtn2 = false;
  bool get activeFilterBtn2 => _activeFilterBtn2;
  set activeFilterBtn2(bool value) {
    _activeFilterBtn2 = value;
    notifyListeners();
  }

  bool _activeFilterBtn3 = true;
  bool get activeFilterBtn3 => _activeFilterBtn3;
  set activeFilterBtn3(bool value) {
    _activeFilterBtn3 = value;
    notifyListeners();
  }

  getDataFromActivatedFilterBtn1() {
    activeFilterBtn1 = true;
    activeFilterBtn2 = false;
    activeFilterBtn3 = false;
    notifyListeners();
  }

  getDataFromActivatedFilterBtn2() {
    activeFilterBtn1 = false;
    activeFilterBtn2 = true;
    activeFilterBtn3 = false;
    notifyListeners();
  }

  getDataFromActivatedFilterBtn3() {
    activeFilterBtn1 = false;
    activeFilterBtn2 = false;
    activeFilterBtn3 = true;
    notifyListeners();
  }

  // FILTER 2
  bool _activeFilter2Btn1 = false;
  bool get activeFilter2Btn1 => _activeFilter2Btn1;
  set activeFilter2Btn1(bool value) {
    _activeFilter2Btn1 = value;
    notifyListeners();
  }

  bool _activeFilter2Btn2 = false;
  bool get activeFilter2Btn2 => _activeFilter2Btn2;
  set activeFilter2Btn2(bool value) {
    _activeFilter2Btn2 = value;
    notifyListeners();
  }

  bool _activeFilter2Btn3 = true;
  bool get activeFilter2Btn3 => _activeFilter2Btn3;
  set activeFilter2Btn3(bool value) {
    _activeFilter2Btn3 = value;
    notifyListeners();
  }

  getDataFromActivatedFilter2Btn1() {
    activeFilter2Btn1 = true;
    activeFilter2Btn2 = false;
    activeFilter2Btn3 = false;
    notifyListeners();
  }

  getDataFromActivatedFilter2Btn2() {
    activeFilter2Btn1 = false;
    activeFilter2Btn2 = true;
    activeFilter2Btn3 = false;
    notifyListeners();
  }

  getDataFromActivatedFilter2Btn3() {
    activeFilter2Btn1 = false;
    activeFilter2Btn2 = false;
    activeFilter2Btn3 = true;
    notifyListeners();
  }
}
