import 'dart:convert';

import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/services/web_api.dart';

class OrderService {
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
    refNo,
    orderPayer,
    couponCode,
  ) async {
    var result;

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
      'order_packaging': '$packageCheckedValue',
      'order_fragile': '$fragileCheckedValue',
      'order_pickup_time': '$selectedTime',
      'order_collection_cash': '$collectionCash',
      'order_ref_no': '$refNo',
      'order_payer': '$orderPayer',
      'order_coupon': '$couponCode',
    };

    print('Before hit Sender: $orderData');

    var response = await post(
      '${WebApi.addOrderURL}',
      body: orderData,
      headers: {
        'APP_KEY': '${WebApi.apiKey}',
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

  // Future<Map> getOrder(context) async {
  //   var result;

  //   var response = await get(
  //     '${WebApi.getOrderURL}/28',
  //     headers: {
  //       'APP_KEY': '${WebApi.apiKey}',
  //       'x-api-key': '${WebApi.xApiKey}',
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
  //   }
  //   print('outside $result');

  //   return result;
  // }

  Future<Map> updateUserOrder(context, user, orderId, orderStatus) async {
    var result;

    var response = await post(
      '${WebApi.updateOrderURL}/$orderId',
      body: {
        'order_status': '$orderStatus',
      },
      headers: {
        'APP_KEY': '${WebApi.apiKey}',
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
}
