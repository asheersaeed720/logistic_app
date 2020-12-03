import 'package:hani_almutairi_logistic/models/search_city.dart';

class Address {
  String senderName,
      senderDistrict,
      senderAddress,
      senderMobileNo,
      receiverName,
      receiverDistrict,
      receiverAddress,
      receiverMobileNo;
  SearchCityModel senderCity;
  SearchCityModel receiverCity;
  String refNo;
  String collectionCashFromReceiver;

  Address({
    this.senderName,
    this.senderCity,
    this.senderDistrict,
    this.senderAddress,
    this.senderMobileNo,
    this.receiverName,
    this.receiverCity,
    this.receiverDistrict,
    this.receiverAddress,
    this.receiverMobileNo,
    this.refNo,
    this.collectionCashFromReceiver,
  });
}
