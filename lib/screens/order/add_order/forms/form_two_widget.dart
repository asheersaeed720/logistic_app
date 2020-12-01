import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/order_success_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/my_addresses.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
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

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final userPvd = Provider.of<UserProvider>(context);

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
    final collectionCashFromReceiver =
        formOneDetails['collectionCashFromReceiver'];
    final refNo = formOneDetails['refNo'];
    final packageCheckedValue = formOneDetails['packageCheckedValue'];
    final fragileCheckedValue = formOneDetails['fragileCheckedValue'];
    final selectedTime = formOneDetails['selectedTime'];
    // test
    final selectedSenderAddress = formOneDetails['selectedSenderAddress'];

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
                _buildSenderAndReceiverDetail(
                  context,
                  user,
                  userPvd,
                  senderName,
                  senderCity,
                  senderMobile,
                  receiverName,
                  receiverCity,
                  receiverMobile,
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
                                  senderName,
                                  senderCity,
                                  senderDistrict,
                                  senderMobile,
                                  receiverName,
                                  receiverCity,
                                  receiverDistrict,
                                  receiverMobile,
                                  collectionCashFromReceiver,
                                  refNo,
                                  packageCheckedValue,
                                  fragileCheckedValue,
                                  selectedTime,
                                  orderPvd.selectedPay,
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
    senderName,
    senderCity,
    senderMobile,
    receiverName,
    receiverCity,
    receiverMobile,
  ) {
    return Row(
      children: [
        FutureBuilder<List<UserAddress>>(
          future: userPvd.getSenderAddresses(user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // List<UserAddress> userAddresses = snapshot.data;
              List<UserAddress> userAddresses = snapshot.data;
              return Card(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                  child: Column(
                    children: [
                      senderName != null
                          ? Text('$senderName')
                          : Text('${userAddresses[0].fullname}'),
                      senderCity != null
                          ? Text('$senderCity')
                          : Text('${userAddresses[0].city}'),
                      senderMobile != null
                          ? Text('$senderMobile')
                          : Text('${userAddresses[0].mobile}'),
                      RaisedButton(
                        onPressed: () {},
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
        FutureBuilder<List<UserAddress>>(
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
                                : Text('${userAddresses[0].fullname}' ?? ''),
                            receiverCity != null
                                ? Text('$receiverCity')
                                : Text('${userAddresses[0].city}'),
                            receiverMobile != null
                                ? Text('$receiverMobile')
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
          groupValue: orderPvd.selectedPay,
          title: Text("${getTranslatedValue(context, 'sender_to_pay')}"),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setSelectedPay(currentVal);
          },
        ),
        RadioListTile(
          value: "${getTranslatedValue(context, 'receiver')}",
          groupValue: orderPvd.selectedPay,
          title: Text("${getTranslatedValue(context, 'receiver_to_pay')}"),
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
