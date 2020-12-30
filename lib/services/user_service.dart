import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:hani_almutairi_logistic/models/balance.dart';
import 'package:hani_almutairi_logistic/models/city.dart';
import 'package:hani_almutairi_logistic/models/notification.dart';
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
        '${WebApi.getUserAddressesURL}',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
          'x-api-key': '${user['token']}',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

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
        // '${WebApi.getUserAddressesURL}/${user['user_id']}',
        '${WebApi.getUserAddressesURL}',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
          'x-api-key': '${user['token']}',
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

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

  delUserAddress(addressId, user) async {
    var result;

    var response = await delete(
      '${WebApi.delUserAddressesURL}/$addressId',
      headers: {
        'APP-KEY': WebApi.appKey,
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

  Future<List<Balance>> getUserbalance(user) async {
    try {
      var response = await get(
        '${WebApi.getBalanceURL}',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
          'x-api-key': '${user['token']}',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        return ([responseJson] as List)
            .map((i) => Balance.fromJson(i))
            .toList();
      } else {
        throw ('Failed to load Balance');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<List<NotificationMessage>> getUserNotification(user) async {
    try {
      var response = await get(
        '${WebApi.getNotificationURL}',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
          'x-api-key': '${user['token']}',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        return (responseJson as List)
            .map((i) => NotificationMessage.fromJson(i))
            .toList();
      } else {
        throw ('Failed to load Notifications');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }

  Future<Map> banktransfer(user, bankName, accountNo, ownerName) async {
    var result;

    final transferData = {
      'fullname': '$bankName',
      'city': '$accountNo',
      'district': '$ownerName',
    };

    print('Before hit: $transferData');

    var response = await post(
      '${WebApi.withDrawAmountURL}',
      body: transferData,
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

  Future<List<City>> getDropCityList() async {
    try {
      var response = await get(
        '${WebApi.getCitiesURL}',
        headers: {
          'APP_KEY': '${WebApi.appKey}',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        print(responseJson);
        return (responseJson as List).map((i) => City.fromJson(i)).toList();
      } else {
        throw ('Failed to load Cities');
      }
    } on SocketException {
      throw ('No Internet connection');
    }
  }
}
