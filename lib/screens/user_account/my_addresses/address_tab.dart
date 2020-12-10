import 'package:flutter/material.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/receiver_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/sender_addresses.dart';

class AddressTab extends StatelessWidget {
  static const String routeName = '/addresses-tab';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "${getTranslatedValue(context, 'sender_address')}"),
              Tab(text: "${getTranslatedValue(context, 'receiver_address')}"),
            ],
          ),
          title: Text("${getTranslatedValue(context, 'my_addresses')}"),
        ),
        body: TabBarView(
          children: [
            SenderAddresses(),
            ReceiverAddresses(),
          ],
        ),
      ),
    );
  }
}
