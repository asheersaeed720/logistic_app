import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';

import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_one_widget.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  static const String routeName = '/add-order';

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final userPvd = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Future.wait(
          [
            orderPvd.getDeliveryCost(user),
            userPvd.getSenderAddresses(user),
            userPvd.getReceiverAddresses(user),
          ],
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map deliveryCost = snapshot.data[0];
            List<UserAddress> senderAddresses = snapshot.data[1];
            List<UserAddress> receiverAddresses = snapshot.data[2];
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey),
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "${getTranslatedValue(context, 'Delivery_outside_riyadh')} \n                 ${deliveryCost['delivery_cost']}",
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.grey),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Text(
                          "${getTranslatedValue(context, 'delivery_inside_riyadh')} \n                 ${deliveryCost['delivery_cost_inside']}",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${getTranslatedValue(context, 'note_warning_that_prices_not_including_vat')}",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).errorColor),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey),
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      FormOneWidget.routeName,
                      arguments: {
                        'senderAddresses': senderAddresses,
                        'receiverAddresses': receiverAddresses,
                        'deliveryCost': [deliveryCost],
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "${getTranslatedValue(context, 'add_order')}",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        "${getTranslatedValue(context, 'create_new_order')}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
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
