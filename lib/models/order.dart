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
    this.orderEmail,
    this.orderAmount,
    this.orderShipping,
    this.orderTotalAmount,
    this.orderStatus,
    this.orderDate,
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
  dynamic orderEmail;
  String orderAmount;
  String orderShipping;
  String orderTotalAmount;
  String orderStatus;
  DateTime orderDate;

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
        orderEmail: json["order_email"],
        orderAmount: json["order_amount"],
        orderShipping: json["order_shipping"],
        orderTotalAmount: json["order_total_amount"],
        orderStatus: json["order_status"],
        orderDate: DateTime.parse(json["order_date"]),
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
        "order_email": orderEmail,
        "order_amount": orderAmount,
        "order_shipping": orderShipping,
        "order_total_amount": orderTotalAmount,
        "order_status": orderStatus,
        "order_date": orderDate.toIso8601String(),
      };
}
