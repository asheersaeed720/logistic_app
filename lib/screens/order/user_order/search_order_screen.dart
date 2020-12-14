import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_item.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class SearchOrderScreen extends StatelessWidget {
  static const String routeName = '/search-order';

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    final searchOrdersArg =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final mobileNo = searchOrdersArg['mobileNo'];
    final trackingNo = searchOrdersArg['trackingNo'];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Search Order'),
      ),
      body: FutureBuilder<List<Order>>(
        future: orderPvd.getSearch(user, mobileNo, trackingNo),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Order> orders = snapshot.data;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, i) => UserOrderItem(
                orders[i].orderId,
                // SENDER DETAILS
                orders[i].orderSenderName,
                orders[i].orderSenderCity,
                orders[i].orderSenderAddress,
                orders[i].orderSenderDistrict,
                orders[i].orderSenderContact,
                // RECEIVER DETAILS
                orders[i].orderRecieverName,
                orders[i].orderRecieverCity,
                orders[i].orderRecieverAddress,
                orders[i].orderRecieverDistrict,
                orders[i].orderRecieverContact,
                // EXTRA DETAILS
                orders[i].orderDate,
                orders[i].orderPickupTime,
                orders[i].orderPackaging,
                orders[i].orderFragile,
                orders[i].orderPayer,
                orders[i].orderCollectionCash,
                orders[i].orderRefNo,
                orders[i].orderStatus,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
          return LoadingIndicator();
        },
      ),
    );
  }
}
