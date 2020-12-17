import 'package:hani_almutairi_logistic/models/search_city.dart';

class AddOrder {
  String orderUserId;
  // RECEIVER DETAIL
  String orderReceiverName;
  String orderReceiverCity;
  String orderReceiverAddress;
  String orderReceiverDistrict;
  String orderReceiverContact;
  // SENDER DETAIL
  String orderSenderName;
  String orderSenderCity;
  String orderSenderAddress;
  String orderSenderDistrict;
  String orderSenderContact;
  // EXTRA DETAIL
  // String orderPickupTime;
  String orderPackaging;
  String orderFragile;
  String orderPayer;
  String orderCollectionCash;
  String orderRefNo;
  String coupon;

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
    // this.orderPickupTime,
    this.orderPackaging,
    this.orderFragile,
    this.orderPayer,
    this.orderCollectionCash,
    this.orderRefNo,
    this.coupon,
  });
}
