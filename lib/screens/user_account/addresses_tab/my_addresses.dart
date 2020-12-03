import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses_tab/receiver_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses_tab/sender_addresses.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class MyAddresses extends StatelessWidget {
  static const String routeName = '/my-addresses';

  @override
  Widget build(BuildContext context) {
    // final userPvd = Provider.of<UserProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              // Tab(text: 'Sender Addresses'),
              // Tab(text: 'Receiver Addresses'),
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
