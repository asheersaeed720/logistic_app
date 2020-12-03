import 'dart:convert';

import 'package:hani_almutairi_logistic/services/web_api.dart';
import 'package:http/http.dart';

class UserService {
  Future<Map> addUserSenderAddress(context, senderAddress, user) async {
    var result;

    final senderAddressData = {
      'fullname': senderAddress.senderName,
      'city': senderAddress.senderCity.toString(),
      'district': senderAddress.senderDistrict,
      'address': senderAddress.senderAddress,
      'mobile': senderAddress.senderMobileNo,
      'type': '0',
    };

    print('Before hit: $senderAddressData');

    var response = await post(
      '${WebApi.addUserAddressesURL}/${user['user_id']}',
      body: senderAddressData,
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
    }

    return result;
  }

  Future<Map> addUserReceiverAddress(context, receiverAddress, user) async {
    var result;

    final receiverAddressData = {
      'fullname': receiverAddress.receiverName,
      'city': receiverAddress.receiverCity.toString(),
      'district': receiverAddress.receiverDistrict,
      'address': receiverAddress.receiverAddress,
      'mobile': receiverAddress.receiverMobileNo,
      'type': '1',
    };

    print('Before hit: $receiverAddressData');

    var response = await post(
      '${WebApi.addUserAddressesURL}/${user['user_id']}',
      body: receiverAddressData,
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
    }

    return result;
  }
}
