import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';

class OrderSuccess extends StatelessWidget {
  static const String routeName = '/order-success';

  @override
  Widget build(BuildContext context) {
    final orderData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final tabPvd = Provider.of<TabProvider>(context);

    final orderId = orderData['orderId'];
    // SENDER DETAILS
    final senderName = orderData['senderName'];
    final senderCity = orderData['senderCity'];
    final senderAddress = orderData['senderAddress'];
    final senderDistrict = orderData['senderDistrict'];
    final senderContact = orderData['senderContact'];
    // RECEIVER DETAILS
    final receiverName = orderData['receiverName'];
    final receiverCity = orderData['receiverCity'];
    final receiverAddress = orderData['receiverAddress'];
    final receiverDistrict = orderData['receiverDistrict'];
    final receiverContact = orderData['receiverContact'];
    // EXTRA DETAILS
    final packageCheckedValue = orderData['packageCheckedValue'];
    final fragileCheckedValue = orderData['fragileCheckedValue'];
    final selectedTime = orderData['selectedTime'];
    final orderPayer = orderData['orderPayer'];
    final refNo = orderData['refNo'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Success'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              child: Center(
                child: Text(
                  'Your Order No: $orderId',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            refNo == null
                ? Text('')
                : Container(
                    width: MediaQuery.of(context).size.width / 1,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red[200],
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Center(
                      child: Text(
                        'Ref: $refNo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                    child: Column(
                      children: [
                        Text('Sender Detail'),
                        const SizedBox(height: 5),
                        Text('$senderName'),
                        const SizedBox(height: 5),
                        Text('$senderCity'),
                        const SizedBox(height: 5),
                        Text('$senderContact'),
                        const SizedBox(height: 5),
                        RaisedButton(
                          onPressed: () {},
                          child: Text(
                            'Invoice',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.2,
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: Column(
                      children: [
                        Text('Receiver Detail'),
                        const SizedBox(height: 5),
                        Text('$receiverName'),
                        const SizedBox(height: 5),
                        Text('$receiverCity'),
                        const SizedBox(height: 5),
                        Text('$receiverContact'),
                        const SizedBox(height: 5),
                        RaisedButton(
                          elevation: 0,
                          color: Colors.white,
                          onPressed: null,
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 0,
              onPressed: () {
                Navigator.of(context).pop();
                tabPvd.onTabTapped(2);
              },
              child: Text(
                'View Order History',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
