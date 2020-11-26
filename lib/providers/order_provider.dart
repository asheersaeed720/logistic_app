import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/services/order_service.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/services/web_api.dart';

class OrderProvider with ChangeNotifier {

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

  resetStepFormNo() {
    stepFormNo = 1;
  }

  
}
