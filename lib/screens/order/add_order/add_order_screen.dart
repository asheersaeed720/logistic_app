import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/delivery_cost.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/form_wizard/form_wizard.dart';

import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_one_widget.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

// class AddOrderScreen extends StatelessWidget {
//   static const String routeName = '/add-order';

//   @override
//   Widget build(BuildContext context) {
//     return FormOneWidget();
//   }
// }

class AddOrderScreen extends StatelessWidget {
  static const String routeName = '/add-order';

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map>(
        future: orderPvd.getDeliveryCost(user),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map deliveryCost = snapshot.data;
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
                          "Delivery outside Riyadh \n                 ${deliveryCost['delivery_cost']}",
                          style: TextStyle(fontSize: 16),
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
                          "Delivery inside Riyadh \n                 ${deliveryCost['delivery_cost_inside']}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Note: Warning that prices not including VAT",
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
                    Navigator.of(context)
                        .pushReplacementNamed(OrderFormWizard.routeName);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        'Add Order',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        'Create new order',
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
