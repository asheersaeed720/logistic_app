import 'dart:convert';
import 'dart:io';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:http/http.dart';

import 'package:hani_almutairi_logistic/utils/web_api.dart';

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

  Future<List<UserAddress>> getSenderAddresses(user) async {
    try {
      var response = await get(
        '${WebApi.getUserAddressesURL}/${user['user_id']}',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
          'x-api-key': '${user['token']}',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return (responseJson['sender'] as List)
            .map((i) => UserAddress.fromJson(i))
            .toList();
      } else {
        throw ('Failed to load Address');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<List<UserAddress>> getReceiverAddresses(user) async {
    try {
      var response = await get(
        '${WebApi.getUserAddressesURL}/${user['user_id']}',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
          'x-api-key': '${user['token']}',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return (responseJson['reciever'] as List)
            .map((i) => UserAddress.fromJson(i))
            .toList();
      } else {
        throw ('Failed to load Address');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<List<UserAddress>> getUserAddressById(user, addressId) async {
    try {
      var response = await get(
        '${WebApi.getUserAddressesByIdURL}/$addressId',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
          'x-api-key': '${user['token']}',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        return (responseJson as List)
            .map((i) => UserAddress.fromJson(i))
            .toList();
      } else {
        throw ('Failed to load Address');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }
}
