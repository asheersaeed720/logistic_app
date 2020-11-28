import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/receiver_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/sender_addresses.dart';

class MyAddresses extends StatelessWidget {
  static const String routeName = '/my-addresses';

  @override
  Widget build(BuildContext context) {
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
