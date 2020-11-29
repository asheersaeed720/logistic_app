import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_one_widget.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_two_widget.dart';
import 'package:provider/provider.dart';

// class AddOrderScreen extends StatelessWidget {
//   static const String routeName = '/add-order';

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     // final stepFormNo = Provider.of<OrderProvider>(context).stepFormNo;

//     switch (stepFormNo) {
//       case 1:
//         return Form(
//           key: _formKey,
//           child: FormOneWidget(),
//         );
//         break;

//       case 2:
//         return Form(
//           key: _formKey,
//           child: FormTwoWidget(),
//         );
//         break;
//     }
//   }
// }

class AddOrderScreen extends StatelessWidget {
  static const String routeName = '/add-order';

  @override
  Widget build(BuildContext context) {
    return FormOneWidget();
  }
}
