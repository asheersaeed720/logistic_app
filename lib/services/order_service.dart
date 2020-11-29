import 'dart:convert';

import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/services/web_api.dart';

class OrderService {
  Future<Map> addUserOrder(
    context,
    user,
    senderName,
    senderCity,
    senderDistrict,
    senderMobile,
    receiverName,
    receiverCity,
    receiverDistrict,
    receiverMobile,
  ) async {
    var result;

    final orderData = {
      'sender_name': '$senderName',
      'sender_address': '$senderDistrict',
      'sender_contact': '$senderMobile',
      'sender_city': '$senderCity',
      'reciever_name': '$receiverName',
      'reciever_address': '$receiverDistrict',
      'reciever_contact': '$receiverMobile',
      'reciever_city': '$receiverCity',
      'order_amount': '155',
      'order_shipping': '23',
      'order_total_amount': '23',
      'order_time': '2020-11-28 06:20:06',
    };

    print('Before hit: $orderData');

    var response = await post(
      '${WebApi.addOrderURL}/${user['user_id']}',
      body: orderData,
      headers: {
        'APP_KEY': '${WebApi.apiKey}',
        'x-api-key': user['token'],
      },
    );

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      result = {'status': true, 'message': 'Successful', 'user': responseJson};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body),
      };
    }

    return result;
  }

  Future<Map> getOrder(context) async {
    var result;

    var response = await get(
      '${WebApi.getOrderURL}/28',
      headers: {
        'APP_KEY': '${WebApi.apiKey}',
        'x-api-key': '${WebApi.xApiKey}',
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
    print('outside $result');

    return result;
  }
}
