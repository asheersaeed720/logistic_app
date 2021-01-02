import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/language.dart';

class SearchCityModel {
  final String id;
  final String name;
  final String cityArabicName;

  SearchCityModel({this.id, this.name, this.cityArabicName});

  factory SearchCityModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return SearchCityModel(
      id: json["city_id"].toString(),
      name: json["city_name"].toString(),
      cityArabicName: json["city_arabic_name"].toString(),
    );
  }

  static List<SearchCityModel> fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => SearchCityModel.fromJson(item)).toList();
  }

  String userAsString() {
    // return '#${this.id} ${this.name} ${this.cityArabicName}';
    return '#${this.id} ${this.name}';
  }

  @override
  String toString() {
    // return id + name + cityArabicName;
    return id + name;
  }
}
