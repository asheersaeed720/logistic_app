import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:provider/provider.dart';

class UserOrderItem extends StatelessWidget {
  final orderId;
  final orderSenderName;
  final orderSenderContact;
  final orderSenderCity;
  final orderSenderAddress;
  final orderRecieverName;
  final orderRecieverContact;
  final orderRecieverCity;
  final orderRecieverAddress;
  final orderStatus;
  final orderRefNo;

  UserOrderItem(
    this.orderId,
    this.orderSenderName,
    this.orderSenderContact,
    this.orderSenderCity,
    this.orderSenderAddress,
    this.orderRecieverName,
    this.orderRecieverContact,
    this.orderRecieverCity,
    this.orderRecieverAddress,
    this.orderStatus,
    this.orderRefNo,
  );

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    return ExpansionTile(
      key: GlobalKey(),
      initiallyExpanded: false,
      // leading: CircleAvatar(
      //   radius: 22.0,
      //   backgroundImage: AssetImage(
      //       './assets/images/student_pic.png'),
      //   backgroundColor:
      //       Theme.of(context).accentColor,
      // ),
      title: Text(
        'Order no: # $orderId',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6, bottom: 10),
              child: Column(
                children: [
                  Text(
                    'Sender Detail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Name: $orderSenderName'),
                  Text('Phone: $orderSenderContact'),
                  Text('City: $orderSenderCity'),
                  Text('Address: $orderSenderAddress'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6, bottom: 10),
              child: Column(
                children: [
                  Text(
                    'Receiver Detail',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Name: $orderRecieverName'),
                  Text('Phone: $orderRecieverContact'),
                  Text('City: $orderRecieverCity'),
                  Text('Address: $orderRecieverAddress'),
                ],
              ),
            ),
          ],
        ),
        Text(
          'Order Status $orderStatus',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text(
          'Order Ref # No: $orderRefNo',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: Text('Order Cancel!'),
                content: Text('Are you sure, You want to cancel order?'),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      orderPvd.delUserOrder(orderId, user);
                      Navigator.of(dialogContext).pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
                elevation: 20,
              ),
            );
          },
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
        ),
      ],
    );
  }
}
