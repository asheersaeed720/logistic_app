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
    final collectionCash = orderData['order_collection_cash'];
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
                  // 'Your Order No: $orderId',
                  'Your Order No',
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
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 3.8,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                    child: Column(
                      children: [
                        Text(
                          'Sender Detail',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('$senderName'),
                        const SizedBox(height: 6),
                        Text('$senderCity'),
                        const SizedBox(height: 6),
                        Text('$senderContact'),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.height / 3.8,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                    child: Column(
                      children: [
                        Text(
                          'Receiver Detail',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('$receiverName'),
                        const SizedBox(height: 6),
                        Text('$receiverCity'),
                        const SizedBox(height: 6),
                        Text('$receiverContact'),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    refNo != null
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 14),
                            child: Text(
                              'Reference no: $refNo',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : Text(
                            '',
                            style: TextStyle(fontSize: 2),
                          ),
                    fragileCheckedValue == true
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 14),
                            child: Image.asset(
                              './assets/images/fragile_sticker.png',
                              width: 120,
                            ),
                          )
                        : Text(
                            '',
                            style: TextStyle(fontSize: 2),
                          ),
                    Text(
                      collectionCash == null
                          ? '0 riyals will be added to your balance if the delivery is successful'
                          : '$collectionCash' +
                              'riyals will be added to your balance if the delivery is successful',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              elevation: 0,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              },
              child: Text(
                'Create another order',
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
            // RaisedButton(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   elevation: 0,
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //     tabPvd.onTabTapped(2);
            //   },
            //   child: Text(
            //     'View Order History',
            //     style: TextStyle(
            //       color: Theme.of(context).primaryColor,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 13,
            //     ),
            //   ),
            //   color: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     side: BorderSide(color: Theme.of(context).primaryColor),
            //   ),
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   onPressed: () {
      //     Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
