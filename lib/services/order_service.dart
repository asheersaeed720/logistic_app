import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/delivery_cost.dart';
import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/search_order_screen.dart';
import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/utils/web_api.dart';

class OrderService {
  Future<Map> getDeliveryCost(user) async {
    try {
      var response = await get(
        '${WebApi.getDeliveryCost}',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson;
      } else if (response.statusCode == 404) {
        throw ('No Delivery Found');
      } else {
        throw ('Failed to load delivery cost');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<Map> addUserOrder(
    context,
    user,
    // SENDER DETAILS
    selectedSenderAddressId,
    senderName,
    senderCity,
    senderAddress,
    senderDistrict,
    senderContact,
    // RECEIVER DETAILS
    selectedReceiverAddressId,
    receiverName,
    receiverCity,
    receiverAddress,
    receiverDistrict,
    receiverContact,
    // EXTRA DETAILS
    packageCheckedValue,
    fragileCheckedValue,
    selectedTime,
    collectionCash,
    deliveryCost,
    refNo,
    isSenderAddressSave,
    isReceiverAddressSave,
    orderPayer,
    couponCode,
  ) async {
    var result;

    var orderTotalAmount = double.parse(collectionCash) + deliveryCost;
    print(orderTotalAmount);

    final orderData = {
      // SENDER DETAILS
      'sender_ad_id': '$selectedSenderAddressId',
      'sender_name': '$senderName',
      'sender_city': '$senderCity',
      'sender_address': '$senderAddress',
      'sender_district': '$senderDistrict',
      'sender_contact': '$senderContact',
      // RECEIVER DETAILS
      'reciever_ad_id': '$selectedReceiverAddressId',
      'reciever_name': '$receiverName',
      'reciever_city': '$receiverCity',
      'reciever_address': '$receiverAddress',
      'reciever_district': '$receiverDistrict',
      'reciever_contact': '$receiverContact',
      // EXTRA DETAILS
      'order_total_amount': '$orderTotalAmount',
      'order_packaging': '$packageCheckedValue',
      'order_fragile': '$fragileCheckedValue',
      'order_pickup_time': '$selectedTime',
      'order_collection_cash': '$collectionCash',
      'order_ref_no': '$refNo',
      'save_sender_address': '$isSenderAddressSave',
      'save_reciever_address': '$isReceiverAddressSave',
      'order_payer': '$orderPayer',
      'order_coupon': '$couponCode',
    };

    print('Before hit Sender: $orderData');

    var response = await post(
      '${WebApi.addOrderURL}',
      body: orderData,
      headers: {
        'APP_KEY': '${WebApi.appKey}',
        'x-api-key': user['token'],
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);

      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
      print(json.decode(response.body));
    }

    return result;
  }

  // Future<Map> addUserOrderTest(
  //   context,
  //   user,
  //   addOrderData,
  //   isSenderAddressSave,
  //   isReceiverAddressSave,
  //   packageCheckedValue,
  //   fragileCheckedValue,
  //   selectedTime,
  //   orderPayer,
  // ) async {
  //   var result;

  //   final orderData = {
  //     // SENDER DETAILS
  //     'sender_ad_id': '',
  //     'sender_name': '${addOrderData.orderSenderName}',
  //     'sender_city': '${addOrderData.orderSenderCity}',
  //     'sender_address': '${addOrderData.orderSenderAddress}',
  //     'sender_district': '${addOrderData.orderSenderDistrict}',
  //     'sender_contact': '${addOrderData.orderSenderContact}',
  //     // RECEIVER DETAILS
  //     'reciever_ad_id': '',
  //     'reciever_name': '${addOrderData.orderReceiverName}',
  //     'reciever_city': '${addOrderData.orderReceiverCity}',
  //     'reciever_address': '${addOrderData.orderReceiverAddress}',
  //     'reciever_district': '${addOrderData.orderReceiverDistrict}',
  //     'reciever_contact': '${addOrderData.orderReceiverContact}',
  //     // EXTRA DETAILS
  //     'order_packaging': '$packageCheckedValue',
  //     'order_fragile': '$fragileCheckedValue',
  //     'order_pickup_time': '$selectedTime',
  //     'order_collection_cash': '${addOrderData.orderCollectionCash}',
  //     'order_ref_no': '${addOrderData.orderRefNo}',
  //     'save_sender_address': '$isSenderAddressSave',
  //     'save_reciever_address': '$isReceiverAddressSave',
  //     'order_payer': '$orderPayer',
  //     'order_coupon': '${addOrderData.coupon}',
  //   };

  //   print('Before hit Sender: $orderData');

  //   var response = await post(
  //     '${WebApi.addOrderURL}',
  //     body: orderData,
  //     headers: {
  //       'APP_KEY': '${WebApi.appKey}',
  //       'x-api-key': user['token'],
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     var responseJson = json.decode(response.body);
  //     print(responseJson);

  //     result = {'status': true, 'message': 'Successful', 'user': responseJson};
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': json.decode(response.body),
  //     };
  //     print(json.decode(response.body));
  //   }

  //   return result;
  // }

  Future<List<Order>> getUserOrder(user) async {
    try {
      var response = await get(
        '${WebApi.getOrderURL}',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        return (responseJson as List).map((i) => Order.fromJson(i)).toList();
      } else if (response.statusCode == 404) {
        throw ('No Orders Found');
      } else {
        throw ('Failed to load orders');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<List<Order>> getUserOrderAsSenderOrReceiver(
      user, receiverORSender, orderStatus) async {
    try {
      var response = await get(
        '${WebApi.getOrderbySenderOrReceiverURL}?q=$receiverORSender&status=$orderStatus',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return (responseJson as List).map((i) => Order.fromJson(i)).toList();
      } else if (response.statusCode == 404) {
        throw ('No Orders Found');
      } else {
        throw ('Failed to load orders');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<List<Order>> getFilterUserOrder(user, String orderStatus) async {
    try {
      var response = await get(
        '${WebApi.getFilterOrdersURL}/?type=$orderStatus',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return (responseJson as List).map((i) => Order.fromJson(i)).toList();
      } else if (response.statusCode == 404) {
        throw ('No Orders Found');
      } else {
        throw ('Failed to load orders');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<List<Order>> getSearchUserOrderByMobile(
      context, user, mobileNo, trackingNo) async {
    try {
      var response = await get(
        '${WebApi.getFilterOrdersURL}?mobilenumber=$mobileNo&trackingnumber=$trackingNo',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        Navigator.of(context).pushNamed(
          SearchOrderScreen.routeName,
          arguments: {
            'mobileNo': mobileNo,
            'trackingNo': trackingNo,
          },
        );
        // return (responseJson as List).map((i) => Order.fromJson(i)).toList();
      } else if (response.statusCode == 404) {
        throw ('No Orders Found');
      } else {
        throw ('Failed to load orders');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<List<Order>> getSearch(user, mobileNo, trackingNo) async {
    try {
      var response = await get(
        '${WebApi.getFilterOrdersURL}?mobilenumber=$mobileNo&trackingnumber=$trackingNo',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        return (responseJson as List).map((i) => Order.fromJson(i)).toList();
      } else if (response.statusCode == 404) {
        throw ('No Orders Found');
      } else {
        throw ('Failed to load orders');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<Map> cancelUserOrder(context, user, orderId, orderStatus) async {
    var result;

    var response = await post(
      '${WebApi.updateOrderURL}/$orderId',
      body: {
        'order_status': '$orderStatus',
      },
      headers: {
        'APP_KEY': '${WebApi.appKey}',
        'x-api-key': user['token'],
      },
    );
    print(orderStatus);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);

      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }

    return result;
  }

  Future<Map> editUserOrder(context, user, orderId, editOrderData) async {
    var result;

    var orderData = {
      'sender_name': '${editOrderData.orderSenderName}',
      'sender_address': '${editOrderData.orderSenderAddress}',
      'sender_district': '${editOrderData.orderSenderDistrict}',
      'sender_contact': '${editOrderData.orderSenderContact}',
      'sender_city': '${editOrderData.orderSenderCity}',
      'reciever_name': '${editOrderData.orderReceiverName}',
      'reciever_address': '${editOrderData.orderReceiverAddress}',
      'reciever_district': '${editOrderData.orderReceiverDistrict}',
      'reciever_contact': '${editOrderData.orderReceiverContact}',
      'reciever_city': '${editOrderData.orderReceiverCity}',
    };

    var response = await post(
      '${WebApi.updateOrderURL}/$orderId',
      body: orderData,
      headers: {
        'APP_KEY': '${WebApi.appKey}',
        'x-api-key': user['token'],
      },
    );
    print(orderData);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }

    return result;
  }

  Future<Map> addUserOrderReport(
    context,
    user,
    _orderReport,
    isShipmentReportSelected,
    isInvoiceReportSelected,
    isBalanceReportSelected,
    isSelectedTransferReport,
  ) async {
    var result;

    var orderReport = {
      'from': '${_orderReport.fromDate}',
      'to': '${_orderReport.toDate}',
      'shipment': '$isShipmentReportSelected',
      'invoice': '$isInvoiceReportSelected',
      'balance': '$isBalanceReportSelected',
      'transfer': '$isSelectedTransferReport',
      'email': '${_orderReport.email}',
    };

    var response = await post(
      '${WebApi.reportOrderURL}',
      body: orderReport,
      headers: {
        'APP_KEY': '${WebApi.appKey}',
        'x-api-key': user['token'],
      },
    );
    print('Before hit: $orderReport');
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
      // print(json.decode(response.body));
    }

    return result;
  }

  Future<List<Order>> trackUserShipment(context, user, mobileNo) async {
    try {
      var response = await get(
        '${WebApi.getFilterOrdersURL}?mobilenumber=$mobileNo&trackingnumber=null',
        headers: {
          'APP-KEY': WebApi.appKey,
          'x-api-key': user['token'],
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        Navigator.of(context).pushNamed(
          SearchOrderScreen.routeName,
          arguments: {
            'mobileNo': mobileNo,
            'trackingNo': null,
          },
        );
      } else if (response.statusCode == 404) {
        throw ('No Orders Found');
      } else {
        throw ('Failed to load orders');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<Map> getCouponCode(user, couponCode) async {
    var result;

    var response = await get(
      '${WebApi.getCouponCodeURL}/$couponCode',
      headers: {
        'APP_KEY': '${WebApi.appKey}',
        'x-api-key': user['token'],
      },
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print(responseJson);
      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }

    return result;
  }
}
