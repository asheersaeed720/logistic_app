import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/receiver_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/sender_addresses.dart';
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
              Tab(text: 'Sender Addresses'),
              Tab(text: 'Receiver Addresses'),
            ],
          ),
          title: Text('My Addresses'),
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
