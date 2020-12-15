import 'dart:io';

import 'package:flutter/material.dart';
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

  // final pdf = pw.Document();

  // writeOnPdf(senderName) {
  //   pdf.addPage(pw.MultiPage(
  //     pageFormat: PdfPageFormat.a5,
  //     margin: pw.EdgeInsets.all(32),
  //     build: (pw.Context context) {
  //       return <pw.Widget>[
  //         pw.Header(
  //           level: 0,
  //           child: pw.Text("Hubex"),
  //         ),
  //         pw.Paragraph(text: "Sender Detail: \n $senderName"),
  //         pw.Paragraph(text: "Receiver Detail \n "),
  //       ];
  //     },
  //   ));
  // }

  // Future savePdf() async {
  //   Directory documentDirectory = await getApplicationDocumentsDirectory();

  //   String documentPath = documentDirectory.path;

  //   File file = File("$documentPath/example.pdf");

  //   file.writeAsBytesSync(pdf.save());

  //   print(documentDirectory.path);
  // }

  var lastSenderCity;
  var lastReceiverCity;

  var senderAddressbyId;
  var receiverAddressbyId;

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

    // var senderCityConvertintoString = senderCity.toString();
    // String senderCityString = senderCityConvertintoString.substring(5);

    // var receiverCityConvertintoString = receiverCity.toString();
    // String receiverCityString = receiverCityConvertintoString.substring(5);

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
                const SizedBox(height: 20),

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
    senderCityString,
    senderAddress,
    senderDistrict,
    senderContact,
    // RECEIVER DETIALS
    selectedReceiverAddressId,
    receiverName,
    receiverCityString,
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
                  senderAddressbyId = userAddresses[0].cityName;
                  if (snapshot.hasData) {
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: MediaQuery.of(context).size.height / 4,
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

                            FutureBuilder<Map>(
                              future: orderPvd.getDeliveryCost(user),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map deliveryCost = snapshot.data;
                                  if (senderAddressbyId == '37444ar-Riyad') {
                                    return Text(
                                      'Delivery cost: ${deliveryCost['delivery_cost_inside']}',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor),
                                    );
                                  } else {
                                    return Text(
                                      'Delivery cost: ${deliveryCost['delivery_cost']}',
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
                            ),

                            // _buildInvoiceButton(context, senderName)
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
            : FutureBuilder<List<UserAddress>>(
                future: userPvd.getSenderAddresses(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserAddress> userAddresses = snapshot.data;
                    lastSenderCity = userAddresses.last.cityName;
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: MediaQuery.of(context).size.height / 4,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 6),
                        child: Column(
                          children: [
                            Text(
                              'Sender Detail',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            senderName != null
                                ? Text('$senderName')
                                : Text('${userAddresses.last.fullname}'),
                            const SizedBox(height: 6),

                            senderCityString != null
                                ? Text('$senderCityString')
                                : Text('${userAddresses.last.cityName}'),
                            const SizedBox(height: 6),

                            senderContact != null
                                ? Text('$senderContact')
                                : Text('${userAddresses.last.mobile}'),
                            const SizedBox(height: 6),

                            orderPvd.orderPayer == 'Sender'
                                ? FutureBuilder<Map>(
                                    future: orderPvd.getDeliveryCost(user),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map deliveryCost = snapshot.data;
                                        if ((lastSenderCity == 'ar-riyadh' &&
                                                lastReceiverCity ==
                                                    'ar-riyadh') ||
                                            (senderCityString == 'ar-riyadh' &&
                                                receiverCityString ==
                                                    'ar-riyadh')) {
                                          return Text(
                                            'Delivery cost: ${deliveryCost['delivery_cost_inside']}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          );
                                        } else {
                                          return Text(
                                            'Delivery cost: ${deliveryCost['delivery_cost']}',
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
                                : Text('')

                            // _buildInvoiceButton(context, senderName)
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
              ),
        Icon(Icons.arrow_forward_rounded),
        selectedReceiverAddressId != null
            ? FutureBuilder<List<UserAddress>>(
                future:
                    userPvd.getUserAddressById(user, selectedReceiverAddressId),
                builder: (context, snapshot) {
                  List<UserAddress> userAddresses = snapshot.data;
                  receiverAddressbyId = userAddresses[0].cityName;
                  if (snapshot.hasData) {
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: MediaQuery.of(context).size.height / 4,
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
                                ? FutureBuilder<Map>(
                                    future: orderPvd.getDeliveryCost(user),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map deliveryCost = snapshot.data;
                                        if (senderAddressbyId ==
                                            '37444ar-Riyad') {
                                          return Text(
                                            'Delivery cost: ${deliveryCost['delivery_cost_inside']}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          );
                                        } else {
                                          return Text(
                                            'Delivery cost: ${deliveryCost['delivery_cost']}',
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
                                : Text(
                                    '',
                                    style: TextStyle(fontSize: 2),
                                  ),

                            Text(
                              'COD Amount: $collectionCash',
                              style: TextStyle(color: Colors.green),
                            ),

                            // _buildInvoiceButton(context, senderName)
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
            : FutureBuilder<List<UserAddress>>(
                future: userPvd.getReceiverAddresses(user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<UserAddress> userAddresses = snapshot.data;
                    return Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.6,
                        height: MediaQuery.of(context).size.height / 4,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6),
                        child: Column(
                          children: [
                            Text(
                              'Receiver Detail',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            receiverName != null
                                ? Text('$receiverName')
                                : Text('${userAddresses.last.fullname}'),
                            const SizedBox(height: 6),

                            receiverCityString != null
                                ? Text('$receiverCityString')
                                : Text('${userAddresses.last.cityName}'),
                            const SizedBox(height: 6),

                            receiverContact != null
                                ? Text('$receiverContact')
                                : Text('${userAddresses.last.mobile}'),
                            const SizedBox(height: 6),

                            orderPvd.orderPayer == 'Receiver'
                                ? FutureBuilder<Map>(
                                    future: orderPvd.getDeliveryCost(user),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Map deliveryCost = snapshot.data;
                                        if ((lastSenderCity == 'ar-riyadh' &&
                                                lastReceiverCity ==
                                                    'ar-riyadh') ||
                                            (senderCityString == 'ar-riyadh' &&
                                                receiverCityString ==
                                                    'ar-riyadh')) {
                                          return Text(
                                            'Delivery cost: ${deliveryCost['delivery_cost_inside']}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .errorColor),
                                          );
                                        } else {
                                          return Text(
                                            'Delivery cost: ${deliveryCost['delivery_cost']}',
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
                                : Text(
                                    '',
                                    style: TextStyle(fontSize: 2),
                                  ),
                            Text(
                              'COD Amount: $collectionCash',
                              style: TextStyle(color: Colors.green),
                            ),

                            // _buildInvoiceButton(context, senderName)
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
              ),
      ],
    );
  }

  Widget _buildInvoiceButton(context, senderName) {
    return RaisedButton(
      onPressed: () async {
        // writeOnPdf(senderName);
        // await savePdf();

        // print(savePdf());

        // Directory documentDirectory = await getApplicationDocumentsDirectory();

        // String documentPath = documentDirectory.path;

        // String fullPath = "$documentPath/example.pdf";

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PdfPreviewScreen(
        //       path: fullPath,
        //     ),
        //   ),
        // );
      },
      child: Text(
        "${getTranslatedValue(context, 'invoice')}",
        style: TextStyle(color: Colors.white),
      ),
      color: Theme.of(context).primaryColor,
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
