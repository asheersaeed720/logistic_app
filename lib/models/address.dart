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
  String refNo;
  String collectionCashFromReceiver;

  Address({
    this.senderName,
    this.senderCity,
    this.senderDistrict,
    this.senderMobileNo,
    this.receiverName,
    this.receiverCity,
    this.receiverDistrict,
    this.receiverMobileNo,
    this.refNo,
    this.collectionCashFromReceiver,
  });
}
