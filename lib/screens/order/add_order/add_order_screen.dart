import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/form_wizard/form_one_widget.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/form_wizard/form_two_widget.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatelessWidget {
  static const String routeName = '/add-order';

  @override
  Widget build(BuildContext context) {
    final stepFormNo = Provider.of<OrderProvider>(context).stepFormNo;

    switch (stepFormNo) {
      case 1:
        return FormOneWidget();
        break;

      case 2:
        return FormTwoWidget();
        break;
    }
  }
}
