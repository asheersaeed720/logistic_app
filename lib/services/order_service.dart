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
    collectionCashFromReceiver,
    refNo,
    packageCheckedValue,
    fragileCheckedValue,
    selectedTime,
    whoWillPlay,
  ) async {
    var result;

    final orderData = {
      'sender_name': senderName.toString(),
      'sender_address': senderDistrict.toString(),
      'sender_contact': senderMobile.toString(),
      'sender_city': senderCity.toString(),
      'reciever_name': receiverName.toString(),
      'reciever_address': receiverDistrict.toString(),
      'reciever_contact': receiverMobile.toString(),
      'reciever_city': receiverCity.toString(),
      'order_amount': '155',
      'order_shipping': '23',
      'order_total_amount': '23',
      'order_pickup_time': selectedTime.toString(),
      'order_collection_cash': collectionCashFromReceiver.toString(),
      'order_ref_no': refNo.toString(),
      'order_packaging': packageCheckedValue.toString(),
      'order_fragile': fragileCheckedValue.toString(),
      'order_payer': whoWillPlay.toString(),
      'order_coupon': '',
    };

    var response = await post(
      // '${WebApi.addOrderURL}/${user['user_id']}',
      '${WebApi.addOrderURL}',
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
      print(json.decode(response.body));
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
