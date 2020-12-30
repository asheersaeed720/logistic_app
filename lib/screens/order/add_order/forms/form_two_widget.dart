import 'dart:async';
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
  final _formKey1 = GlobalKey<FormState>();

  String _couponCode;

  Timer _timer;

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
    var isSenderAddressSave = formOneDetails['isSenderAddressSave'];
    List<UserAddress> senderDetail = formOneDetails['senderDetail'];

    // RECEIVER DETAIL
    var selectedReceiverAddressId = formOneDetails['selectedReceiverAddressId'];
    var receiverName = formOneDetails['receiverName'];
    var receiverCity = formOneDetails['receiverCity'];
    var receiverAddress = formOneDetails['receiverAddress'];
    var receiverDistrict = formOneDetails['receiverDistrict'];
    var receiverContact = formOneDetails['receiverContact'];
    var isReceiverAddressSave = formOneDetails['isReceiverAddressSave'];
    List<UserAddress> receiverDetail = formOneDetails['receiverDetail'];

    // EXTRA DETAILS
    var packageCheckedValue = formOneDetails['packageCheckedValue'];
    var fragileCheckedValue = formOneDetails['fragileCheckedValue'];
    var selectedTime = formOneDetails['selectedTime'];
    var collectionCash = formOneDetails['collectionCash'];

    List deliveryCost = formOneDetails['deliveryCost'];
    var refNo = formOneDetails['refNo'];

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    selectedSenderAddressId == null
                        ? _buildSenderCard(
                            context,
                            orderPvd,
                            deliveryCost,
                            senderName,
                            senderCity,
                            senderAddress,
                            senderDistrict,
                            senderContact,
                            selectedReceiverAddressId == null
                                ? receiverCity
                                : receiverDetail
                                    .where((element) => element.id
                                        .contains(selectedReceiverAddressId))
                                    .map((e) => e.cityName),
                          )
                        : Column(
                            children: [
                              ...(senderDetail)
                                  .where((element) => element.id
                                      .contains(selectedSenderAddressId))
                                  .map((e) {
                                return _buildSenderCardBySelectedAddressId(
                                  context,
                                  orderPvd,
                                  deliveryCost,
                                  e.fullname,
                                  e.cityName,
                                  e.mobile,
                                  selectedReceiverAddressId == null
                                      ? receiverCity
                                      : receiverDetail
                                          .where((element) => element.id
                                              .contains(
                                                  selectedReceiverAddressId))
                                          .map((e) => e.cityName),
                                );
                              })
                            ],
                          ),
                    selectedReceiverAddressId == null
                        ? _buildReceiverCard(
                            context,
                            orderPvd,
                            collectionCash,
                            deliveryCost,
                            receiverName,
                            receiverCity,
                            receiverAddress,
                            receiverDistrict,
                            receiverContact,
                            selectedSenderAddressId == null
                                ? senderCity
                                : senderDetail
                                    .where((element) => element.id
                                        .contains(selectedSenderAddressId))
                                    .map((e) => e.cityName),
                          )
                        : Column(
                            children: [
                              ...(receiverDetail)
                                  .where((element) => element.id
                                      .contains(selectedReceiverAddressId))
                                  .map((e) {
                                return _buildReceiverCardBySelectedAddressId(
                                  context,
                                  orderPvd,
                                  collectionCash,
                                  deliveryCost,
                                  e.fullname,
                                  e.cityName,
                                  e.mobile,
                                  selectedSenderAddressId == null
                                      ? senderCity
                                      : senderDetail
                                          .where((element) => element.id
                                              .contains(
                                                  selectedSenderAddressId))
                                          .map((e) => e.cityName),
                                );
                              })
                            ],
                          )
                  ],
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
                          // '$collectionCash riyals will be added to your balance if the delivery is successful',
                          '$collectionCash ${getTranslatedValue(context, 'riyals_will_be_added_to_your_balance')}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // DELIVERY COST SECTION
                _buildDeliveryCostAndCoupon(context, orderPvd, collectionCash),

                orderPvd.isLoading
                    ? LoadingIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // setState(() {
                              //   senderCity = null;
                              //   receiverCity = null;
                              // });
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
                                  orderPvd.calculatedDeliveryCost,
                                  refNo,
                                  isSenderAddressSave,
                                  isReceiverAddressSave,
                                  orderPvd.orderPayer,
                                  _couponCode,
                                );
                              }
                            },
                            child: Text(
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

  Widget _buildSenderCard(
    context,
    orderPvd,
    deliveryCost,
    senderName,
    senderCity,
    senderAddress,
    senderDistrict,
    senderContact,
    // RECEIVER CITY
    receiverCity,
  ) {
    if (senderCity.toString().replaceAll(RegExp(r'[0-9]'), '') == 'ar-Riyad' &&
        (receiverCity.toString() == '(ar-Riyad)' ||
            receiverCity.toString().replaceAll(RegExp(r'[0-9]'), '') ==
                'ar-Riyad')) {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost_inside']);
        // _timer.cancel();
      });
    } else {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost = orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost']);
      });
    }

    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 3.8,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: Column(
          children: [
            Text(
              'Sender Detail',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('$senderName'),
            const SizedBox(height: 6),
            Text(senderCity.toString().replaceAll(RegExp(r'[0-9]'), '')),
            const SizedBox(height: 6),
            Text('$senderContact'),
            const SizedBox(height: 6),
            if (orderPvd.orderPayer == 'Sender')
              Text(
                'Delivery cost: ${orderPvd.calculatedDeliveryCost}',
                style: TextStyle(color: Theme.of(context).errorColor),
              )
            else
              Text('', style: TextStyle(fontSize: 2)),
          ],
        ),
      ),
    );
  }

  Widget _buildSenderCardBySelectedAddressId(
    context,
    orderPvd,
    deliveryCost,
    senderName,
    senderCity,
    senderContact,
    // RECEIVER
    receiverCity,
  ) {
    if (senderCity.toString().replaceAll(RegExp(r'[0-9]'), '') == 'ar-Riyad' &&
        (receiverCity.toString() == '(ar-Riyad)' ||
            receiverCity.toString().replaceAll(RegExp(r'[0-9]'), '') ==
                'ar-Riyad')) {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost_inside']);
      });
    } else {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost = orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost']);
      });
    }
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 3.8,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: Column(
          children: [
            Text(
              'Sender Detail',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('$senderName'),
            const SizedBox(height: 6),
            Text(senderCity.toString().replaceAll(RegExp(r'[0-9]'), '')),
            const SizedBox(height: 6),
            Text('$senderContact'),
            const SizedBox(height: 6),
            if (orderPvd.orderPayer == 'Sender')
              Text(
                'Delivery cost: ${orderPvd.calculatedDeliveryCost}',
                style: TextStyle(color: Theme.of(context).errorColor),
              )
            else
              Text('', style: TextStyle(fontSize: 2)),
          ],
        ),
      ),
    );
  }

  _buildReceiverCard(
    context,
    orderPvd,
    collectionCash,
    deliveryCost,
    receiverName,
    receiverCity,
    receiverAddress,
    receiverDistrict,
    receiverContact,
    // SENDER CITY
    senderCity,
  ) {
    if (receiverCity.toString().replaceAll(RegExp(r'[0-9]'), '') ==
            'ar-Riyad' &&
        (senderCity.toString() == '(ar-Riyad)' ||
            senderCity.toString().replaceAll(RegExp(r'[0-9]'), '') ==
                'ar-Riyad')) {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost_inside']);
      });
    } else {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost = orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost']);
      });
    }
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 3.8,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          children: [
            Text(
              'Receiver Detail',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('$receiverName'),
            const SizedBox(height: 6),
            Text(receiverCity.toString().replaceAll(RegExp(r'[0-9]'), '')),
            const SizedBox(height: 6),
            Text('$receiverContact'),
            const SizedBox(height: 6),
            if (orderPvd.orderPayer == 'Receiver')
              Text(
                'Delivery cost: ${orderPvd.calculatedDeliveryCost}',
                style: TextStyle(color: Theme.of(context).errorColor),
              )
            else
              Text('', style: TextStyle(fontSize: 2)),
            Text(
              'COD Amount: $collectionCash',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiverCardBySelectedAddressId(
    context,
    orderPvd,
    collectionCash,
    deliveryCost,
    receiverName,
    receiverCity,
    receiverContact,
    // SENDER CITY
    senderCity,
  ) {
    if (receiverCity.toString().replaceAll(RegExp(r'[0-9]'), '') ==
            'ar-Riyad' &&
        (senderCity.toString() == '(ar-Riyad)' ||
            senderCity.toString().replaceAll(RegExp(r'[0-9]'), '') ==
                'ar-Riyad')) {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost_inside']);
      });
    } else {
      _timer = Timer(Duration(seconds: 1), () {
        orderPvd.calculatedDeliveryCost = orderPvd.calculatedDeliveryCost =
            double.parse(deliveryCost[0]['delivery_cost']);
      });
    }
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 3.8,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: Column(
          children: [
            Text(
              'Receiver Detail',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('$receiverName'),
            const SizedBox(height: 6),
            Text(receiverCity.toString().replaceAll(RegExp(r'[0-9]'), '')),
            const SizedBox(height: 6),
            Text('$receiverContact'),
            const SizedBox(height: 6),
            if (orderPvd.orderPayer == 'Receiver')
              Text(
                'Delivery cost: ${orderPvd.calculatedDeliveryCost}',
                style: TextStyle(color: Theme.of(context).errorColor),
              )
            else
              Text('', style: TextStyle(fontSize: 2)),
            Text(
              'COD Amount: $collectionCash',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  // DELIVERY COST SECTION
  Widget _buildDeliveryCostAndCoupon(context, orderPvd, collectionCash) {
    final authPvd = Provider.of<AuthProvider>(context);
    final couponCodeField = TextFormField(
      onSaved: (value) => _couponCode = value,
      keyboardType: TextInputType.name,
      validator: (value) => value.isEmpty ? "Please enter coupon code" : null,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'coupon')}", Icons.tag_faces_sharp),
    );

    return Form(
      key: _formKey1,
      child: Column(
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
          // orderPvd.loadingForCoupon
          //     ? LoadingIndicator()
          //     : RaisedButton(
          //         onPressed: () {
          //           if (_formKey1.currentState.validate()) {
          //             _formKey1.currentState.save();
          //             orderPvd.getCouponCode(
          //               context,
          //               authPvd.user,
          //               _couponCode,
          //               collectionCash,
          //             );
          //           }
          //         },
          //         child: Text(
          //           "Add Coupon code",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //         color: Theme.of(context).primaryColor,
          //       ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
