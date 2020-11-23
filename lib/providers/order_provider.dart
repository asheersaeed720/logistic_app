import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
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

  List _cities = List();
  List get cities => _cities;
  set cities(cityVal) {
    _cities = cityVal;
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

  Future<List<SearchCityModel>> getCities(filter) async {
    var response = await Dio().get(
      // "http://5d85ccfb1e61af001471bf60.mockapi.io/user",
      "https://restcountries.eu/rest/v2/all",
      queryParameters: {"filter": filter},
    );

    var models = SearchCityModel.fromJsonList(response.data);
    return models;
  }
}
