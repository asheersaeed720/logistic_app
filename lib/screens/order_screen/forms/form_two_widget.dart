import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/address_filter_data/new_address_form.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/address_filter_data/time_radio_btn.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/form_widget.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/order_success_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:provider/provider.dart';

class FormTwoWidget extends StatefulWidget {
  // static const String routeName = '/form-one';

  @override
  _FormTwoWidgetState createState() => _FormTwoWidgetState();
}

class _FormTwoWidgetState extends State<FormTwoWidget> {
  final _formKey = GlobalKey<FormState>();

  int _stepNumber = 1;

  void nextPage(BuildContext context) {
    setState(() {
      if (_stepNumber == 1)
        _stepNumber = 2;
      else
        _stepNumber = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);

    final couponCodeField = TextFormField(
      autofocus: false,
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration('Coupon', Icons.tag_faces_sharp),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width / 2.3,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                child: Column(
                  children: [
                    Text('Receiver Name'),
                    Text('City'),
                    Text('Country'),
                    Text('Mobile No'),
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
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                child: Column(
                  children: [
                    Text('Sender Name'),
                    Text('City'),
                    Text('Country'),
                    Text('Mobile No'),
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
            )
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.work),
          iconSize: 26,
        ),
        Divider(),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            'Search as a sender',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 12),
        _buildHeader(context, 'Who will be paying the delivery cost'),
        SizedBox(height: 6),
        RadioListTile(
          value: 1,
          groupValue: 1,
          title: Text('Sender to pay'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
        RadioListTile(
          value: 2,
          groupValue: 2,
          title: Text('Receiver to pay'),
          activeColor: Colors.black54,
          onChanged: (currentVal) {
            print(currentVal);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: couponCodeField,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                orderPvd.formNavigation();
              },
              child: Text(
                'Back/Edit',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 8.0),
            RaisedButton(
              onPressed: () {
                orderPvd.resetStepFormNo();
                Navigator.of(context)
                    .pushReplacementNamed(OrderSuccess.routeName);
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildHeader(BuildContext context, headerTitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      width: MediaQuery.of(context).size.width / 1,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        gradient: new LinearGradient(
          colors: [
            CustomColor.gradientEnd,
            CustomColor.gradientStart,
          ],
          begin: const FractionalOffset(0.2, 0.2),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Text(
          headerTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.5,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
