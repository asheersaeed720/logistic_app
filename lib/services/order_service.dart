import 'dart:convert';

import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/services/web_api.dart';

class OrderService {
  Future<Map> addUserOrder(context) async {
    var result;

    final orderData = {
      'first_name': 'Shakir',
      'last_name': 'Afzal',
      'order_address': 'central khi',
      'order_contact': '123456789',
      'order_city': '12457',
      'order_amount': '1000',
      'order_shipping': '200',
      'order_total_amount': '3000',
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
}
