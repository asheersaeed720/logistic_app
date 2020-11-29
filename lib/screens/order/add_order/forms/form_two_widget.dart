import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/order_success_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';
import './form_one_widget.dart';

class FormTwoWidget extends StatefulWidget {
  static const String routeName = '/add-order-form-two';

  @override
  _FormTwoWidgetState createState() => _FormTwoWidgetState();
}

class _FormTwoWidgetState extends State<FormTwoWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    final formOneDetails =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final senderName = formOneDetails['senderName'];
    final senderCity = formOneDetails['senderCity'];
    final senderDistrict = formOneDetails['senderDistrict'];
    final senderMobile = formOneDetails['senderMobile'];
    final receiverName = formOneDetails['receiverName'];
    final receiverCity = formOneDetails['receiverCity'];
    final receiverDistrict = formOneDetails['receiverDistrict'];
    final receiverMobile = formOneDetails['receiverMobile'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SENDER & RECEIVER DETAIL SECTION
                _buildSenderAndReceiverDetail(context),
                const SizedBox(height: 20),
                // DELIVERY COST SECTION
                _buildDeliveryCostAndCoupon(context, orderPvd),
                orderPvd.isLoading
                    ? LoadingIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print(senderName);
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
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                orderPvd.addOrder(
                                  context,
                                  user,
                                  senderName,
                                  senderCity,
                                  senderDistrict,
                                  senderMobile,
                                  receiverName,
                                  receiverCity,
                                  receiverDistrict,
                                  receiverMobile,
                                );
                              }
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

  // SENDER & RECEIVER DETAIL SECTION
  Widget _buildSenderAndReceiverDetail(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width / 2.3,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
            child: Column(
              children: [
                Text('Shakir Afzal'),
                Text('Al-Madina'),
                Text('5862135'),
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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
            child: Column(
              children: [
                Text('Asif Khan'),
                Text('Riyadh'),
                Text('59266551'),
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

  // DELIVERY COST SECTION
  Widget _buildDeliveryCostAndCoupon(context, orderPvd) {
    final couponCodeField = TextFormField(
      autofocus: false,
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration:
          buildTextFieldInputDecoration('Coupon', Icons.tag_faces_sharp),
    );
    return Column(
      children: [
        HeadingTitle('Who will be paying the delivery cost'),
        const SizedBox(height: 6),
        RadioListTile(
          value: 'Sender',
          groupValue: orderPvd.selectedPay,
          title: Text('Sender to pay'),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setSelectedPay(currentVal);
          },
        ),
        RadioListTile(
          value: 'Receiver',
          groupValue: orderPvd.selectedPay,
          title: Text('Receiver to pay'),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setSelectedPay(currentVal);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: couponCodeField,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
