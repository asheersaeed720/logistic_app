import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:intl/intl.dart';
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
  var orderStatus;
  final orderRefNo;
  final orderDate;

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
    this.orderDate,
  );

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final tabPvd = Provider.of<TabProvider>(context);

    return orderPvd.isLoading
        ? Text('')
        : Card(
            child: ExpansionTile(
              key: GlobalKey(),
              initiallyExpanded: false,
              title: Text(
                '$orderSenderName',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text('$orderSenderCity $orderSenderContact'),
              // expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.topLeft,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date $orderDate',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Tracking no: 2321322232',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(width: 10),
                                RaisedButton(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  elevation: 0,
                                  onPressed: () {
                                    print('2321322232');
                                  },
                                  child: Text(
                                    'Copy',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Order no: $orderId',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sender Detail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Name: $orderSenderName'),
                      SizedBox(height: 4),
                      Text('Phone: $orderSenderContact'),
                      SizedBox(height: 4),
                      Text('City: $orderSenderCity'),
                      SizedBox(height: 4),
                      Text('Address: $orderSenderAddress'),
                      SizedBox(height: 6),
                      Divider(color: Colors.grey),
                      SizedBox(height: 4),
                      Text(
                        'Receiver Detail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Name: $orderRecieverName'),
                      SizedBox(height: 4),
                      Text('Phone: $orderRecieverContact'),
                      SizedBox(height: 4),
                      Text('City: $orderRecieverCity'),
                      SizedBox(height: 4),
                      Text('Address: $orderRecieverAddress'),
                      SizedBox(height: 6),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Order Status: $orderStatus',
                  style: TextStyle(
                    color: orderStatus == 'PROCESSING'
                        ? Colors.green
                        : orderStatus == 'PENDING'
                            ? Colors.orange
                            : Theme.of(context).errorColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                orderStatus == 'CANCELLED'
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: Text('Order Cancel!'),
                              content: Text(
                                  'Are you sure, You want to cancel order?'),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text('No'),
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    orderPvd.delUserOrder(
                                        tabPvd.onTabTapped(2), orderId, user);
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                              elevation: 20,
                            ),
                          );
                          // orderPvd.delUserOrder(tabPvd.onTabTapped(2), orderId, user);
                        },
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                      )
                    : Container(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {},
                              child: Text(
                                'EDIT',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text('Order Cancel!'),
                                    content: Text(
                                        'Are you sure, You want to cancel order?'),
                                    actions: [
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          orderPvd.updateOrder(
                                              context,
                                              user,
                                              orderId,
                                              orderStatus = 'CANCELLED');
                                          Navigator.of(dialogContext).pop();
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                    elevation: 20,
                                  ),
                                );
                              },
                              child: Text(
                                'ORDER CANCEL',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 4),
              ],
            ),
          );
  }
}
