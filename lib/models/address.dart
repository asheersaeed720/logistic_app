import 'package:hani_almutairi_logistic/models/search_city.dart';

class Address {
  String senderName,
      senderDistrict,
      senderMobileNo,
      receiverName,
      receiverDistrict,
      receiverMobileNo;
  SearchCityModel senderCity;
  SearchCityModel receiverCity;

  Address({
    this.senderName,
    this.senderCity,
    this.senderDistrict,
    this.senderMobileNo,
    this.receiverName,
    this.receiverCity,
    this.receiverDistrict,
    this.receiverMobileNo,
  });
}
