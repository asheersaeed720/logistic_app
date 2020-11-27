import 'package:flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hani_almutairi_logistic/screens/order/order_success_screen.dart';
import 'package:hani_almutairi_logistic/services/order_service.dart';

import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  OrderService _orderService = OrderService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool loadVal) {
    _isLoading = loadVal;
    notifyListeners();
  }

  String _selectedAddress = 'Person name 1';
  String get selectedAddress => _selectedAddress;
  set selectedAddress(String val) {
    _selectedAddress = val;
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

  int _stepFormNo = 1;
  int get stepFormNo => _stepFormNo;
  set stepFormNo(int indexVal) {
    _stepFormNo = indexVal;
    notifyListeners();
  }

  formNavigation() {
    if (stepFormNo == 1) {
      stepFormNo = 2;
    } else {
      stepFormNo = 1;
    }
  }

  setSelectedAddress(String selectedValue) {
    selectedAddress = selectedValue;
    print(selectedAddress);
  }

  setSelectedTime(String selectedValue) {
    selectedTime = selectedValue;
    print(selectedTime);
  }

  setSelectedPay(String selectedValue) {
    selectedPay = selectedValue;
    print(selectedPay);
  }

  addOrder(context) async {
    isLoading = true;
    await _orderService.addUserOrder(context).then((response) {
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
        stepFormNo = 1;
        Navigator.of(context).pushNamed(
          OrderSuccess.routeName,
          arguments: {},
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
}
