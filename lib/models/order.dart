class Order {
  Order({
    this.orderId,
    this.orderUserId,
    this.orderSenderName,
    this.orderSenderContact,
    this.orderSenderAddress,
    this.orderSenderCity,
    this.orderSenderDistrict,
    this.orderRecieverDistrict,
    this.orderRecieverName,
    this.orderRecieverAddress,
    this.orderRecieverContact,
    this.orderRecieverCity,
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
  String orderSenderDistrict;
  String orderRecieverDistrict;
  String orderRecieverName;
  String orderRecieverAddress;
  String orderRecieverContact;
  String orderRecieverCity;
  String orderStatus;
  String orderDate;
  String orderPickupTime;
  String orderCollectionCash;
  String orderRefNo;
  String orderPackaging;
  String orderFragile;
  String orderPayer;
  String orderCoupon;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json['order_id'],
        orderUserId: json['order_user_id'],
        orderSenderName: json['order_sender_name'],
        orderSenderContact: json['order_sender_contact'],
        orderSenderAddress: json['order_sender_address'],
        orderSenderCity: json['order_sender_city'],
        orderSenderDistrict: json['order_sender_district'],
        orderRecieverDistrict: json['order_reciever_district'],
        orderRecieverName: json['order_reciever_name'],
        orderRecieverAddress: json['order_reciever_address'],
        orderRecieverContact: json['order_reciever_contact'],
        orderRecieverCity: json['order_reciever_city'],
        orderStatus: json['order_status'],
        orderDate: json['order_date'],
        orderPickupTime: json['order_pickup_time'],
        orderCollectionCash: json['order_collection_cash'],
        orderRefNo: json['order_ref_no'],
        orderPackaging: json['order_packaging'],
        orderFragile: json['order_fragile'],
        orderPayer: json['order_payer'],
        orderCoupon: json['order_coupon'],
      );
}
