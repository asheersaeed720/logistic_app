import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatelessWidget {
  static const String routeName = '/order-success';

  @override
  Widget build(BuildContext context) {
    final orderData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final user = Provider.of<AuthProvider>(context).user;
    final userPvd = Provider.of<UserProvider>(context);

    final orderId = orderData['orderId'];
    final senderName = orderData['senderName'];
    final senderCity = orderData['senderCity'];
    final senderDistrict = orderData['senderDistrict'];
    final senderMobile = orderData['senderMobile'];
    final receiverName = orderData['receiverName'];
    final receiverCity = orderData['receiverCity'];
    final receiverDistrict = orderData['receiverDistrict'];
    final receiverMobile = orderData['receiverMobile'];
    final refNo = orderData['refNo'];

    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 36, right: 10, left: 10, bottom: 10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
            const SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width / 1,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Center(
                child: refNo == null
                    ? Text('Your did not your ref no')
                    : Column(
                        children: [
                          Text(
                            'Customer Unique number',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            '$refNo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
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
                        Text('$senderName'),
                        Text('$senderCity'),
                        Text('$senderMobile'),
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
                        Text('$receiverName'),
                        Text('$receiverCity'),
                        Text('$receiverMobile'),
                        RaisedButton(
                          elevation: 0,
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ),
                          // color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                // FutureBuilder<List<UserAddress>>(
                //   future: userPvd.getSenderAddresses(user),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       // List<UserAddress> userAddresses = snapshot.data;
                //       List<UserAddress> userAddresses = snapshot.data;
                //       return Card(
                //         child: Container(
                //           width: MediaQuery.of(context).size.width / 2.3,
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 16, horizontal: 6),
                //           child: Column(
                //             children: [
                //               senderName != null
                //                   ? Text('$senderName')
                //                   : Text('${userAddresses[0].fullname}'),
                //               senderCity != null
                //                   ? Text('$senderCity')
                //                   : Text('${userAddresses[0].city}'),
                //               senderMobile != null
                //                   ? Text('$senderMobile')
                //                   : Text('${userAddresses[0].mobile}'),
                //               RaisedButton(
                //                 onPressed: () {},
                //                 child: Text(
                //                   'Invoice',
                //                   style: TextStyle(color: Colors.white),
                //                 ),
                //                 color: Theme.of(context).primaryColor,
                //               )
                //             ],
                //           ),
                //         ),
                //       );
                //     } else if (snapshot.hasError) {
                //       return Center(child: Text('No Sender Addresses Found!'));
                //       // return snapshot.error;
                //     }
                //     return LoadingIndicator();
                //   },
                // ),
                // FutureBuilder<List<UserAddress>>(
                //   future: userPvd.getReceiverAddresses(user),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       List<UserAddress> userAddresses = snapshot.data;
                //       return Card(
                //         child: Container(
                //           width: MediaQuery.of(context).size.width / 2.2,
                //           padding: const EdgeInsets.symmetric(
                //               vertical: 12, horizontal: 6),
                //           child: Column(
                //             children: [
                //               receiverName != null
                //                   ? Text('$receiverName')
                //                   : Text('${userAddresses[0].fullname}'),
                //               receiverCity != null
                //                   ? Text('$receiverCity')
                //                   : Text('${userAddresses[0].city}'),
                //               receiverMobile != null
                //                   ? Text('$receiverMobile')
                //                   : Text('${userAddresses[0].mobile}'),
                //               RaisedButton(
                //                 elevation: 0,
                //                 color: Colors.white,
                //                 onPressed: () {},
                //                 child: Text(
                //                   '',
                //                   style: TextStyle(color: Colors.white),
                //                 ),
                //                 // color: Theme.of(context).primaryColor,
                //               )
                //             ],
                //           ),
                //         ),
                //       );
                //     } else if (snapshot.hasError) {
                //       return Center(
                //           child: Text('No Receiver Addresses Found!'));
                //       // return snapshot.error;
                //     }
                //     return LoadingIndicator();
                //   },
                // ),
              ],
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
