import 'package:hani_almutairi_logistic/models/search_city.dart';

class Order {
  Order({
    this.orderId,
    this.orderUserId,
    this.orderSenderName,
    this.orderSenderContact,
    this.orderSenderAddress,
    this.orderSenderCity,
    this.orderRecieverName,
    this.orderRecieverAddress,
    this.orderRecieverContact,
    this.orderRecieverCity,
    this.orderAmount,
    this.orderShipping,
    this.orderTotalAmount,
    this.orderStatus,
    this.orderDate,
    this.orderPickupTime,
    this.orderCollectionCash,
    this.orderRefNo,
    this.orderPackaging,
    this.orderFragile,
    this.orderPayer,
    this.orderCoupon,
  });

  String orderId;
  String orderUserId;
  String orderSenderName;
  String orderSenderContact;
  String orderSenderAddress;
  String orderSenderCity;
  String orderRecieverName;
  String orderRecieverAddress;
  String orderRecieverContact;
  String orderRecieverCity;
  String orderAmount;
  String orderShipping;
  String orderTotalAmount;
  String orderStatus;
  DateTime orderDate;
  String orderPickupTime;
  String orderCollectionCash;
  String orderRefNo;
  String orderPackaging;
  String orderFragile;
  String orderPayer;
  String orderCoupon;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        orderUserId: json["order_user_id"],
        orderSenderName: json["order_sender_name"],
        orderSenderContact: json["order_sender_contact"],
        orderSenderAddress: json["order_sender_address"],
        orderSenderCity: json["order_sender_city"],
        orderRecieverName: json["order_reciever_name"],
        orderRecieverAddress: json["order_reciever_address"],
        orderRecieverContact: json["order_reciever_contact"],
        orderRecieverCity: json["order_reciever_city"],
        orderAmount: json["order_amount"],
        orderShipping: json["order_shipping"],
        orderTotalAmount: json["order_total_amount"],
        orderStatus: json["order_status"],
        orderDate: DateTime.parse(json["order_date"]),
        orderPickupTime: json["order_pickup_time"],
        orderCollectionCash: json["order_collection_cash"],
        orderRefNo: json["order_ref_no"],
        orderPackaging: json["order_packaging"],
        orderFragile: json["order_fragile"],
        orderPayer: json["order_payer"],
        orderCoupon: json["order_coupon"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_user_id": orderUserId,
        "order_sender_name": orderSenderName,
        "order_sender_contact": orderSenderContact,
        "order_sender_address": orderSenderAddress,
        "order_sender_city": orderSenderCity,
        "order_reciever_name": orderRecieverName,
        "order_reciever_address": orderRecieverAddress,
        "order_reciever_contact": orderRecieverContact,
        "order_reciever_city": orderRecieverCity,
        "order_amount": orderAmount,
        "order_shipping": orderShipping,
        "order_total_amount": orderTotalAmount,
        "order_status": orderStatus,
        "order_date": orderDate.toIso8601String(),
        "order_pickup_time": orderPickupTime,
        "order_collection_cash": orderCollectionCash,
        "order_ref_no": orderRefNo,
        "order_packaging": orderPackaging,
        "order_fragile": orderFragile,
        "order_payer": orderPayer,
        "order_coupon": orderCoupon,
      };
}

class AddOrder {
  String orderId;
  String orderUserId;
  String orderSenderName;
  String orderSenderContact;
  String orderSenderAddress;
  SearchCityModel orderSenderCity;
  String orderRecieverName;
  String orderRecieverAddress;
  String orderRecieverContact;
  SearchCityModel orderRecieverCity;
  String orderAmount;
  String orderShipping;
  String orderTotalAmount;
  String orderStatus;
  DateTime orderDate;
  String orderPickupTime;
  String orderCollectionCash;
  String orderRefNo;
  String orderFragile;
  String orderPayer;
  String orderCoupon;
  String recieverAdId;
  String senderAdId;

  AddOrder({
    this.orderId,
    this.orderUserId,
    this.orderSenderName,
    this.orderSenderContact,
    this.orderSenderAddress,
    this.orderSenderCity,
    this.orderRecieverName,
    this.orderRecieverAddress,
    this.orderRecieverContact,
    this.orderRecieverCity,
    this.orderAmount,
    this.orderShipping,
    this.orderTotalAmount,
    this.orderStatus,
    this.orderDate,
    this.orderPickupTime,
    this.orderCollectionCash,
    this.orderRefNo,
    this.orderFragile,
    this.orderPayer,
    this.orderCoupon,
    this.recieverAdId,
    this.senderAdId,
  });
}
