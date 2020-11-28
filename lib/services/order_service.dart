import 'dart:convert';

import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/services/web_api.dart';

class OrderService {
  Future<Map> addUserOrder(context) async {
    var result;

    final orderData = {
      'sender_name': 'asd',
      'sender_address': 'asd',
      'sender_contact': '222',
      'sender_city': '37410',
      'reciever_name': 'xyz',
      'reciever_address': 'das',
      'reciever_contact': '232',
      'reciever_city': '37410',
      'order_amount': '155',
      'order_shipping': '23',
      'order_total_amount': '23',
      'order_time': '2020-11-28 06:20:06',
    };

    var response = await post(
      '${WebApi.addOrderURL}/28',
      body: orderData,
      headers: {
        'APP_KEY': '${WebApi.apiKey}',
        'x-api-key': '${WebApi.xApiKey}',
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
    print('outside $result');

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
