import 'dart:async';
import 'dart:convert';
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

  Future<List> getCities() async {
    String url = 'https://restcountries.eu/rest/v2/all';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> responseBody = json.decode(response.body);
      List<String> countries = new List();
      for (int i = 0; i < responseBody.length; i++) {
        countries.add(responseBody[i]['name']);
      }
      return countries;
    } else {
      print("error from server : $response");
      throw Exception('Failed to load post');
    }
  }
}
