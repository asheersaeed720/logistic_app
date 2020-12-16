import 'package:hani_almutairi_logistic/models/search_city.dart';

class AddOrder {
  String orderUserId;
  String orderReceiverName;
  String orderReceiverCity;
  // SearchCityModel orderReceiverCity;
  String orderReceiverAddress;
  String orderReceiverDistrict;
  String orderReceiverContact;
  String orderSenderName;
  String orderSenderCity;
  // SearchCityModel orderSenderCity;
  String orderSenderAddress;
  String orderSenderDistrict;
  String orderSenderContact;
  String orderPickupTime;
  String orderPackaging;
  String orderFragile;
  String orderPayer;
  String orderCollectionCash;
  String orderRefNo;

  AddOrder({
    this.orderUserId,
    this.orderReceiverName,
    this.orderReceiverCity,
    this.orderReceiverAddress,
    this.orderReceiverDistrict,
    this.orderReceiverContact,
    this.orderSenderName,
    this.orderSenderCity,
    this.orderSenderAddress,
    this.orderSenderDistrict,
    this.orderSenderContact,
    this.orderPickupTime,
    this.orderPackaging,
    this.orderFragile,
    this.orderPayer,
    this.orderCollectionCash,
    this.orderRefNo,
  });
}
