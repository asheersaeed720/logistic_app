import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/add_order.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_one_widget.dart';
// import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
// import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/address_tab.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

class FormTwoWidget extends StatefulWidget {
  static const String routeName = '/add-order-form-two';

  @override
  _FormTwoWidgetState createState() => _FormTwoWidgetState();
}

class _FormTwoWidgetState extends State<FormTwoWidget> {
  final _formKey = GlobalKey<FormState>();

  String _couponCode;

  var senderAddressbyIdCity;
  var receiverAddressbyIdCity;

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final userPvd = Provider.of<UserProvider>(context);

    final formOneDetails =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    var selectedSenderAddressId = formOneDetails['selectedSenderAddressId'];
    var senderName = formOneDetails['senderName'];
    var senderCity = formOneDetails['senderCity'];
    var senderAddress = formOneDetails['senderAddress'];
    var senderDistrict = formOneDetails['senderDistrict'];
    var senderContact = formOneDetails['senderContact'];

    // RECEIVER DETAIL
    var selectedReceiverAddressId = formOneDetails['selectedReceiverAddressId'];
    var receiverName = formOneDetails['receiverName'];
    var receiverCity = formOneDetails['receiverCity'];
    var receiverAddress = formOneDetails['receiverAddress'];
    var receiverDistrict = formOneDetails['receiverDistrict'];
    var receiverContact = formOneDetails['receiverContact'];

    // EXTRA DETAILS
    var packageCheckedValue = formOneDetails['packageCheckedValue'];
    var fragileCheckedValue = formOneDetails['fragileCheckedValue'];
    var selectedTime = formOneDetails['selectedTime'];
    var collectionCash = formOneDetails['collectionCash'];
    var refNo = formOneDetails['refNo'];
    var isSenderAddressSave = formOneDetails['isSenderAddressSave'];
    var isReceiverAddressSave = formOneDetails['isReceiverAddressSave'];

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
                  orderPvd,
                  collectionCash,
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
                const SizedBox(height: 18),

                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        refNo != ''
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: Text(
                                  'Reference no: $refNo',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Text(
                                '',
                                style: TextStyle(fontSize: 2),
                              ),
                        fragileCheckedValue == true
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: Image.asset(
                                  './assets/images/fragile_sticker.png',
                                  width: 120,
                                ),
                              )
                            : Text(
                                '',
                                style: TextStyle(fontSize: 2),
                              ),
                        Text(
                          '$collectionCash riyals will be added to your balance if the delivery is successful',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // DELIVERY COST SECTION
                _buildDeliveryCostAndCoupon(context, orderPvd),

                // Text(collectionCash),

                orderPvd.isLoading
                    ? LoadingIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
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
                                  isSenderAddressSave,
                                  isReceiverAddressSave,
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
    orderPvd,
    collectionCash,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        selectedSenderAddressId != null
            ? FutureBuilder<List<UserAddress>>(
                future:
                    userPvd.getUserAddressById(user, selectedSenderAddressId),
                builder: (context, snapshot) {
                  List<UserAddress> userAddresses = snapshot.data;
                  if (snapshot.hasData) {
                    senderAddressbyIdCity = userAddresses[0].cityName;
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 3.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6),
                        child: Column(
                          children: [
                            Text(
                              'Sender Detail',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text('${userAddresses[0].fullname}'),
                            const SizedBox(height: 6),
                            Text('${userAddresses[0].cityName}'),
                            const SizedBox(height: 6),
                            Text('${userAddresses[0].mobile}'),
                            const SizedBox(height: 6),
                            orderPvd.orderPayer == 'Sender'
                                ? FutureBuilder(
                                    future: orderPvd.getDeliveryCost(user),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map deliveryCost = snapshot.data;
                                        var costInside = deliveryCost[
                                            'delivery_cost_inside'];
                                        var costOutside =
                                            deliveryCost['delivery_cost'];

                                        if ((senderCity == 'ar-Riyad' &&
                                                receiverCity == 'ar-Riyad') ||
                                            (senderAddressbyIdCity ==
                                                    'ar-Riyad' &&
                                                receiverAddressbyIdCity ==
                                                    'ar-Riyad')) {
                                          return Text(
                                            'Delivery cost: $costInside',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          );
                                        } else {
                                          return Text(
                                            'Delivery cost: $costOutside',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text('${snapshot.error}'),
                                        );
                                      }
                                      return LoadingIndicator();
                                    },
                                  )
                                : Text('', style: TextStyle(fontSize: 2)),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return LoadingIndicator();
                },
              )
            : Card(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 3.8,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                  child: Column(
                    children: [
                      Text(
                        'Sender Detail',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('$senderName'),
                      const SizedBox(height: 6),
                      // Text('${senderCity.replaceAll(RegExp(r'[0-9]'), '')}'),
                      Text('$senderCity'),
                      const SizedBox(height: 6),
                      Text('$senderContact'),
                      const SizedBox(height: 6),
                      orderPvd.orderPayer == 'Sender'
                          ? FutureBuilder(
                              future: orderPvd.getDeliveryCost(user),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map deliveryCost = snapshot.data;
                                  var costInside =
                                      deliveryCost['delivery_cost_inside'];
                                  var costOutside =
                                      deliveryCost['delivery_cost'];

                                  if ((senderCity == 'ar-Riyad' &&
                                          receiverCity == 'ar-Riyad') ||
                                      (senderAddressbyIdCity == 'ar-Riyad' &&
                                          receiverAddressbyIdCity ==
                                              'ar-Riyad')) {
                                    return Text(
                                      'Delivery cost: $costInside',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor),
                                    );
                                  } else {
                                    return Text(
                                      'Delivery cost: $costOutside',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor),
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('${snapshot.error}'),
                                  );
                                }
                                return LoadingIndicator();
                              },
                            )
                          : Text('', style: TextStyle(fontSize: 2)),
                    ],
                  ),
                ),
              ),
        Icon(Icons.arrow_forward_rounded),
        selectedReceiverAddressId != null
            ? FutureBuilder<List<UserAddress>>(
                future:
                    userPvd.getUserAddressById(user, selectedReceiverAddressId),
                builder: (context, snapshot) {
                  List<UserAddress> userAddresses = snapshot.data;
                  if (snapshot.hasData) {
                    receiverAddressbyIdCity = userAddresses[0].cityName;
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 3.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6),
                        child: Column(
                          children: [
                            Text(
                              'Receiver Detail',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text('${userAddresses[0].fullname}'),
                            const SizedBox(height: 6),
                            Text('${userAddresses[0].cityName}'),
                            const SizedBox(height: 6),
                            Text('${userAddresses[0].mobile}'),
                            const SizedBox(height: 6),
                            orderPvd.orderPayer == 'Receiver'
                                ? FutureBuilder(
                                    future: orderPvd.getDeliveryCost(user),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map deliveryCost = snapshot.data;
                                        var costInside = deliveryCost[
                                            'delivery_cost_inside'];
                                        var costOutside =
                                            deliveryCost['delivery_cost'];

                                        if ((senderCity == 'ar-Riyad' &&
                                                receiverCity == 'ar-Riyad') ||
                                            (senderAddressbyIdCity ==
                                                    'ar-Riyad' &&
                                                receiverAddressbyIdCity ==
                                                    'ar-Riyad')) {
                                          return Text(
                                            'Delivery cost: $costInside',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          );
                                        } else {
                                          return Text(
                                            'Delivery cost: $costOutside',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Center(
                                          child: Text('${snapshot.error}'),
                                        );
                                      }
                                      return LoadingIndicator();
                                    },
                                  )
                                : Text('', style: TextStyle(fontSize: 2)),
                            Text(
                              'COD Amount: $collectionCash',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return LoadingIndicator();
                },
              )
            : Card(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 3.8,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  child: Column(
                    children: [
                      Text(
                        'Receiver Detail',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('$receiverName'),
                      const SizedBox(height: 6),
                      // Text('${receiverCity.replaceAll(RegExp(r'[0-9]'), '')}'),
                      Text('$receiverCity'),
                      const SizedBox(height: 6),
                      Text('$receiverContact'),
                      const SizedBox(height: 6),
                      orderPvd.orderPayer == 'Receiver'
                          ? FutureBuilder(
                              future: orderPvd.getDeliveryCost(user),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map deliveryCost = snapshot.data;
                                  var costInside =
                                      deliveryCost['delivery_cost_inside'];
                                  var costOutside =
                                      deliveryCost['delivery_cost'];

                                  if ((senderCity == 'ar-Riyad' &&
                                          receiverCity == 'ar-Riyad') ||
                                      (senderAddressbyIdCity == 'ar-Riyad' &&
                                          receiverAddressbyIdCity ==
                                              'ar-Riyad')) {
                                    return Text(
                                      'Delivery cost: $costInside',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor),
                                    );
                                  } else {
                                    return Text(
                                      'Delivery cost: $costOutside',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor),
                                    );
                                  }
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('${snapshot.error}'),
                                  );
                                }
                                return LoadingIndicator();
                              },
                            )
                          : Text('', style: TextStyle(fontSize: 2)),
                      Text(
                        'COD Amount: $collectionCash',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
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
