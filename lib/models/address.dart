import 'package:hani_almutairi_logistic/models/search_city.dart';

class Address {
  String senderName, senderDistrict, senderMobileNo;
  SearchCityModel senderCity;

  Address({
    this.senderName,
    this.senderCity,
    this.senderDistrict,
    this.senderMobileNo,
  });
}
