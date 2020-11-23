import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/order_success_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:provider/provider.dart';

class FormTwoWidget extends StatefulWidget {
  @override
  _FormTwoWidgetState createState() => _FormTwoWidgetState();
}

class _FormTwoWidgetState extends State<FormTwoWidget> {
  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SENDER & RECEIVER DETAIL SECTION
                _buildSenderAndReceiverDetail(context),
                SizedBox(height: 20),
                // DELIVERY COST SECTION
                _buildDeliveryCostAndCoupon(context),
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
                        'Order Now',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // DELIVERY COST SECTION
  Widget _buildDeliveryCostAndCoupon(context) {
    final couponCodeField = TextFormField(
      autofocus: false,
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration('Coupon', Icons.tag_faces_sharp),
    );
    return Column(
      children: [
        HeadingTitle('Who will be paying the delivery cost'),
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
      ],
    );
  }

  // SENDER & RECEIVER DETAIL SECTION
  Widget _buildSenderAndReceiverDetail(context) {
    return Row(
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
                  elevation: 0,
                  color: Colors.white,
                  onPressed: () {},
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.white),
                  ),
                  // color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
