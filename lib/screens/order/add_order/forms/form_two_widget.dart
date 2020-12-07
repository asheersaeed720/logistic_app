import 'dart:io';
import 'dart:typed_data';

import 'package:hani_almutairi_logistic/widgets/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses_tab/my_addresses.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class FormTwoWidget extends StatefulWidget {
  static const String routeName = '/add-order-form-two';

  @override
  _FormTwoWidgetState createState() => _FormTwoWidgetState();
}

class _FormTwoWidgetState extends State<FormTwoWidget> {
  final _formKey = GlobalKey<FormState>();

  String _couponCode;

  test() {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    final file = File('example.pdf');
    file.writeAsBytesSync(doc.save());
  }

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final userPvd = Provider.of<UserProvider>(context);

    final formOneDetails =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final selectedSenderAddressId = formOneDetails['selectedSenderAddressId'];
    final senderName = formOneDetails['senderName'];
    final senderCity = formOneDetails['senderCity'];
    final senderAddress = formOneDetails['senderAddress'];
    final senderDistrict = formOneDetails['senderDistrict'];
    final senderContact = formOneDetails['senderContact'];

    // RECEIVER DETAIL
    final selectedReceiverAddressId =
        formOneDetails['selectedReceiverAddressId'];
    final receiverName = formOneDetails['receiverName'];
    final receiverCity = formOneDetails['receiverCity'];
    final receiverAddress = formOneDetails['receiverAddress'];
    final receiverDistrict = formOneDetails['receiverDistrict'];
    final receiverContact = formOneDetails['receiverContact'];

    // EXTRA DETAILS
    final packageCheckedValue = formOneDetails['packageCheckedValue'];
    final fragileCheckedValue = formOneDetails['fragileCheckedValue'];
    final selectedTime = formOneDetails['selectedTime'];
    final collectionCash = formOneDetails['collectionCash'];
    final refNo = formOneDetails['refNo'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // SENDER & RECEIVER DETAIL SECTION
                _buildSenderAndReceiverDetail(
                  context,
                  user,
                  userPvd,
                  // SENDER DETIALS
                  selectedSenderAddressId,
                  senderName,
                  senderCity,
                  senderAddress,
                  senderDistrict,
                  senderContact,
                  // RECEIVER DETIALS
                  selectedReceiverAddressId,
                  receiverName,
                  receiverCity,
                  receiverAddress,
                  receiverDistrict,
                  receiverContact,
                ),
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
                              // 'Back/Edit',
                              "${getTranslatedValue(context, 'back/edit')}",
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
                                  // SENDER DETAILS
                                  selectedSenderAddressId,
                                  senderName,
                                  senderCity,
                                  senderAddress,
                                  senderDistrict,
                                  senderContact,
                                  // RECEIVER DETAILS
                                  selectedReceiverAddressId,
                                  receiverName,
                                  receiverCity,
                                  receiverAddress,
                                  receiverDistrict,
                                  receiverContact,
                                  // EXTRA DETAILS
                                  packageCheckedValue,
                                  fragileCheckedValue,
                                  selectedTime,
                                  collectionCash,
                                  refNo,
                                  orderPvd.orderPayer,
                                  _couponCode,
                                );
                              }
                            },
                            child: Text(
                              // 'Order Now',
                              "${getTranslatedValue(context, 'order_now')}",
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
  Widget _buildSenderAndReceiverDetail(
    context,
    user,
    userPvd,
    // SENDER DETIALS
    selectedSenderAddressId,
    senderName,
    senderCity,
    senderAddress,
    senderDistrict,
    senderContact,
    // RECEIVER DETIALS
    selectedReceiverAddressId,
    receiverName,
    receiverCity,
    receiverAddress,
    receiverDistrict,
    receiverContact,
  ) {
    return Row(
      children: [
        selectedSenderAddressId != null
            ? FutureBuilder<List<UserAddress>>(
                future:
                    userPvd.getUserAddressById(user, selectedSenderAddressId),
                builder: (context, snapshot) {
                  List<UserAddress> userAddresses = snapshot.data;
                  if (snapshot.hasData) {
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6),
                        child: Column(
                          children: [
                            Text('${userAddresses[0].fullname}'),
                            Text('${userAddresses[0].city}'),
                            Text('${userAddresses[0].mobile}'),
                            RaisedButton(
                              onPressed: () {
                                test();
                              },
                              child: Text(
                                "${getTranslatedValue(context, 'invoice')}",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('No Sender Addresses Found!'),
                    );
                  }
                  return LoadingIndicator();
                },
              )
            : FutureBuilder<List<UserAddress>>(
                future: userPvd.getSenderAddresses(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserAddress> userAddresses = snapshot.data;
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6),
                        child: Column(
                          children: [
                            senderName != null
                                ? Text('$senderName')
                                : Text('${userAddresses[0].fullname}'),
                            senderCity != null
                                ? Text('$senderCity')
                                : Text('${userAddresses[0].city}'),
                            senderContact != null
                                ? Text('$senderContact')
                                : Text('${userAddresses[0].mobile}'),
                            RaisedButton(
                              onPressed: () {
                                test();
                              },
                              child: Text(
                                "${getTranslatedValue(context, 'invoice')}",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('No Sender Addresses Found!'));
                    // return snapshot.error;
                  }
                  return LoadingIndicator();
                },
              ),
        selectedReceiverAddressId != null
            ? FutureBuilder<List<UserAddress>>(
                future:
                    userPvd.getUserAddressById(user, selectedReceiverAddressId),
                builder: (context, snapshot) {
                  List<UserAddress> userAddresses = snapshot.data;
                  if (snapshot.hasData) {
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6),
                        child: Column(
                          children: [
                            Text('${userAddresses[0].fullname}'),
                            Text('${userAddresses[0].city}'),
                            Text('${userAddresses[0].mobile}'),
                            RaisedButton(
                              onPressed: () {
                                test();
                              },
                              child: Text(
                                "${getTranslatedValue(context, 'invoice')}",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('No Sender Addresses Found!'),
                    );
                  }
                  return LoadingIndicator();
                },
              )
            : FutureBuilder<List<UserAddress>>(
                future: userPvd.getReceiverAddresses(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserAddress> userAddresses = snapshot.data;
                    return userAddresses.isEmpty
                        ? Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 6),
                              child: Column(
                                children: [
                                  Text('You did not add receiver address'),
                                  RaisedButton(
                                    elevation: 0,
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(MyAddresses.routeName);
                                    },
                                    child: Text(
                                      'Add receiver address',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    // color: Theme.of(context).primaryColor,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 6),
                              child: Column(
                                children: [
                                  receiverName != null
                                      ? Text('$receiverName')
                                      : Text(
                                          '${userAddresses[0].fullname}' ?? ''),
                                  receiverCity != null
                                      ? Text('$receiverCity')
                                      : Text('${userAddresses[0].city}'),
                                  receiverContact != null
                                      ? Text('$receiverContact')
                                      : Text('${userAddresses[0].mobile}'),
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
                          );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('No Receiver Addresses Found!'));
                    // return snapshot.error;
                  }
                  return LoadingIndicator();
                },
              ),
      ],
    );
  }

  // DELIVERY COST SECTION
  Widget _buildDeliveryCostAndCoupon(context, orderPvd) {
    final couponCodeField = TextFormField(
      onSaved: (value) => _couponCode = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'coupon')}", Icons.tag_faces_sharp),
    );
    return Column(
      children: [
        HeadingTitle(
            "${getTranslatedValue(context, 'who_will_be_paying_the_delievery')}"),
        const SizedBox(height: 6),
        RadioListTile(
          value: "${getTranslatedValue(context, 'sender')}",
          groupValue: orderPvd.orderPayer,
          title: Text("${getTranslatedValue(context, 'sender_to_pay')}"),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setOrderPayer(currentVal);
          },
        ),
        RadioListTile(
          value: "${getTranslatedValue(context, 'receiver')}",
          groupValue: orderPvd.orderPayer,
          title: Text("${getTranslatedValue(context, 'receiver_to_pay')}"),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setOrderPayer(currentVal);
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
