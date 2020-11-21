import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/forms/form_one_widget.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/forms/form_two_widget.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  static const String routeName = '/add-order';

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final stepFormNo = Provider.of<OrderProvider>(context).stepFormNo;

    switch (stepFormNo) {
      case 1:
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Form(
                key: _formKey,
                child: FormOneWidget(),
              ),
            ),
          ),
        );
        break;

      case 2:
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Form(
                key: _formKey,
                child: FormTwoWidget(),
              ),
            ),
          ),
        );
        break;
    }
  }

  // void dispose() {
  //   ctl_address.dispose();
  //   ctl_age.dispose();
  //   ctl_city.dispose();
  //   ctl_name.dispose();
  // }

}
