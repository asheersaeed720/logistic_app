import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class TrackMyShipmentScreen extends StatefulWidget {
  static const String routeName = '/track-my-shipment';

  @override
  _TrackMyShipmentScreenState createState() => _TrackMyShipmentScreenState();
}

class _TrackMyShipmentScreenState extends State<TrackMyShipmentScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _mobileNoValue;

  List<Order> orders;

  void trackShipment(_mobileNoValue) {}

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);

    final countriesCodeField = TextFormField(
      initialValue: '966',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '966',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
    final mobileField = TextFormField(
      maxLength: 9,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a phone number';
        } else if (_mobileNoValue.length < 9) {
          return 'Invalid Number';
        }
        return null;
      },
      onChanged: (text) {
        setState(() {
          _mobileNoValue = '966$text';
        });
        print(_mobileNoValue);
      },
      keyboardType: TextInputType.number,
      onSaved: (value) {
        setState(() {
          _mobileNoValue = '966$value';
        });
      },
      decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Track My Shipment'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 23.0),
                    width: MediaQuery.of(context).size.width / 5.3,
                    child: countriesCodeField,
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: mobileField,
                  ),
                ],
              ),
              const SizedBox(height: 13),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    orderPvd.trackShipment(
                        context, authPvd.user, _mobileNoValue);
                  }
                },
                child: Text(
                  'Track',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
