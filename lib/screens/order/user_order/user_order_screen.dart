import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/search_order_screen.dart';

import 'package:provider/provider.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/order.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_item.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/filter_btn.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

class UserOrderScreen extends StatefulWidget {
  static const String routeName = '/user-order';

  @override
  _UserOrderScreenState createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _mobileNoValue, _trackingNoValue;

  List<Order> orders;

  @override
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _filterBtn(
                context,
                '  All Order',
                "${getTranslatedValue(context, 'mobile')}",
                "${getTranslatedValue(context, 'receiver')}",
                "${getTranslatedValue(context, 'sender')}",
                filterPvd.orderFilterBtn1,
                filterPvd.orderFilterBtn2,
                filterPvd.orderFilterBtn3,
                filterPvd.orderFilterBtn4,
                filterPvd.activateOrderFilterBtn1,
                filterPvd.activateOrderFilterBtn2,
                filterPvd.activateOrderFilterBtn3,
                filterPvd.activateOrderFilterBtn4,
              ),
              const SizedBox(height: 14),
              if (filterPvd.orderFilterBtn1 == true)
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: FutureBuilder<List<Order>>(
                    future: orderPvd.getOrders(user),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        orders = snapshot.data;
                        return ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, i) => UserOrderItem(
                            orders[i].orderId,
                            // SENDER DETAILS
                            orders[i].orderSenderName,
                            orders[i].orderSenderCity,
                            orders[i].orderSenderAddress,
                            orders[i].orderSenderDistrict,
                            orders[i].orderSenderContact,
                            // RECEIVER DETAILS
                            orders[i].orderRecieverName,
                            orders[i].orderRecieverCity,
                            orders[i].orderRecieverAddress,
                            orders[i].orderRecieverDistrict,
                            orders[i].orderRecieverContact,
                            // EXTRA DETAILS
                            orders[i].orderDate,
                            orders[i].orderPickupTime,
                            orders[i].orderPackaging,
                            orders[i].orderFragile,
                            orders[i].orderPayer,
                            orders[i].orderCollectionCash,
                            orders[i].orderRefNo,
                            orders[i].orderStatus,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "${snapshot.error}",
                          ),
                        );
                      }
                      return LoadingIndicator();
                    },
                  ),
                )
              else if (filterPvd.orderFilterBtn2 == true)
                Column(
                  children: [
                    HeadingTitle(
                      "${getTranslatedValue(context, 'search_by_mobile_and_tracking_number')}",
                    ),
                    const SizedBox(height: 22),
                    _buildSearchByMobile(context, orderPvd, user),
                  ],
                )
              else if (filterPvd.orderFilterBtn3 == true)
                Column(
                  children: [
                    HeadingTitle('Receiver'),
                    OrderStatusFilterBtn(
                      'New',
                      "${getTranslatedValue(context, 'not_delivered')}",
                      "${getTranslatedValue(context, 'finished_orders')}",
                      filterPvd.orderStatusFilterBtn1,
                      filterPvd.orderStatusFilterBtn2,
                      filterPvd.orderStatusFilterBtn3,
                      filterPvd.activateOrderStatusFilterBtn1,
                      filterPvd.activateOrderStatusFilterBtn2,
                      filterPvd.activateOrderStatusFilterBtn3,
                    ),
                    if (filterPvd.orderStatusFilterBtn1 == true)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: FutureBuilder<List<Order>>(
                          future: orderPvd.getOrdersAsSenderOrReceiver(
                              user, 'reciever', 'PENDING'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Order> orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, i) => UserOrderItem(
                                  orders[i].orderId,
                                  // SENDER DETAILS
                                  orders[i].orderSenderName,
                                  orders[i].orderSenderCity,
                                  orders[i].orderSenderAddress,
                                  orders[i].orderSenderDistrict,
                                  orders[i].orderSenderContact,
                                  // RECEIVER DETAILS
                                  orders[i].orderRecieverName,
                                  orders[i].orderRecieverCity,
                                  orders[i].orderRecieverAddress,
                                  orders[i].orderRecieverDistrict,
                                  orders[i].orderRecieverContact,
                                  // EXTRA DETAILS
                                  orders[i].orderDate,
                                  orders[i].orderPickupTime,
                                  orders[i].orderPackaging,
                                  orders[i].orderFragile,
                                  orders[i].orderPayer,
                                  orders[i].orderCollectionCash,
                                  orders[i].orderRefNo,
                                  orders[i].orderStatus,
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
                      )
                    else if (filterPvd.orderStatusFilterBtn2 == true)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: FutureBuilder<List<Order>>(
                          future: orderPvd.getOrdersAsSenderOrReceiver(
                              user, 'reciever', 'INCOMPLETE'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Order> orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, i) => UserOrderItem(
                                  orders[i].orderId,
                                  // SENDER DETAILS
                                  orders[i].orderSenderName,
                                  orders[i].orderSenderCity,
                                  orders[i].orderSenderAddress,
                                  orders[i].orderSenderDistrict,
                                  orders[i].orderSenderContact,
                                  // RECEIVER DETAILS
                                  orders[i].orderRecieverName,
                                  orders[i].orderRecieverCity,
                                  orders[i].orderRecieverAddress,
                                  orders[i].orderRecieverDistrict,
                                  orders[i].orderRecieverContact,
                                  // EXTRA DETAILS
                                  orders[i].orderDate,
                                  orders[i].orderPickupTime,
                                  orders[i].orderPackaging,
                                  orders[i].orderFragile,
                                  orders[i].orderPayer,
                                  orders[i].orderCollectionCash,
                                  orders[i].orderRefNo,
                                  orders[i].orderStatus,
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
                      )
                    else if (filterPvd.orderStatusFilterBtn3 == true)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: FutureBuilder<List<Order>>(
                          future: orderPvd.getOrdersAsSenderOrReceiver(
                              user, 'reciever', 'COMPLETE'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Order> orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, i) => UserOrderItem(
                                  orders[i].orderId,
                                  // SENDER DETAILS
                                  orders[i].orderSenderName,
                                  orders[i].orderSenderCity,
                                  orders[i].orderSenderAddress,
                                  orders[i].orderSenderDistrict,
                                  orders[i].orderSenderContact,
                                  // RECEIVER DETAILS
                                  orders[i].orderRecieverName,
                                  orders[i].orderRecieverCity,
                                  orders[i].orderRecieverAddress,
                                  orders[i].orderRecieverDistrict,
                                  orders[i].orderRecieverContact,
                                  // EXTRA DETAILS
                                  orders[i].orderDate,
                                  orders[i].orderPickupTime,
                                  orders[i].orderPackaging,
                                  orders[i].orderFragile,
                                  orders[i].orderPayer,
                                  orders[i].orderCollectionCash,
                                  orders[i].orderRefNo,
                                  orders[i].orderStatus,
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
                      )
                  ],
                )
              else if (filterPvd.orderFilterBtn4 == true)
                Column(
                  children: [
                    HeadingTitle('Sender'),
                    OrderStatusFilterBtn(
                      'New',
                      "${getTranslatedValue(context, 'not_delivered')}",
                      "${getTranslatedValue(context, 'finished_orders')}",
                      filterPvd.orderStatusFilterBtn1,
                      filterPvd.orderStatusFilterBtn2,
                      filterPvd.orderStatusFilterBtn3,
                      filterPvd.activateOrderStatusFilterBtn1,
                      filterPvd.activateOrderStatusFilterBtn2,
                      filterPvd.activateOrderStatusFilterBtn3,
                    ),
                    if (filterPvd.orderStatusFilterBtn1 == true)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: FutureBuilder<List<Order>>(
                          future: orderPvd.getOrdersAsSenderOrReceiver(
                              user, 'sender', 'PENDING'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Order> orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, i) => UserOrderItem(
                                  orders[i].orderId,
                                  // SENDER DETAILS
                                  orders[i].orderSenderName,
                                  orders[i].orderSenderCity,
                                  orders[i].orderSenderAddress,
                                  orders[i].orderSenderDistrict,
                                  orders[i].orderSenderContact,
                                  // RECEIVER DETAILS
                                  orders[i].orderRecieverName,
                                  orders[i].orderRecieverCity,
                                  orders[i].orderRecieverAddress,
                                  orders[i].orderRecieverDistrict,
                                  orders[i].orderRecieverContact,
                                  // EXTRA DETAILS
                                  orders[i].orderDate,
                                  orders[i].orderPickupTime,
                                  orders[i].orderPackaging,
                                  orders[i].orderFragile,
                                  orders[i].orderPayer,
                                  orders[i].orderCollectionCash,
                                  orders[i].orderRefNo,
                                  orders[i].orderStatus,
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
                      )
                    else if (filterPvd.orderStatusFilterBtn2 == true)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: FutureBuilder<List<Order>>(
                          future: orderPvd.getOrdersAsSenderOrReceiver(
                              user, 'sender', 'INCOMPLETE'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Order> orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, i) => UserOrderItem(
                                  orders[i].orderId,
                                  // SENDER DETAILS
                                  orders[i].orderSenderName,
                                  orders[i].orderSenderCity,
                                  orders[i].orderSenderAddress,
                                  orders[i].orderSenderDistrict,
                                  orders[i].orderSenderContact,
                                  // RECEIVER DETAILS
                                  orders[i].orderRecieverName,
                                  orders[i].orderRecieverCity,
                                  orders[i].orderRecieverAddress,
                                  orders[i].orderRecieverDistrict,
                                  orders[i].orderRecieverContact,
                                  // EXTRA DETAILS
                                  orders[i].orderDate,
                                  orders[i].orderPickupTime,
                                  orders[i].orderPackaging,
                                  orders[i].orderFragile,
                                  orders[i].orderPayer,
                                  orders[i].orderCollectionCash,
                                  orders[i].orderRefNo,
                                  orders[i].orderStatus,
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
                      )
                    else if (filterPvd.orderStatusFilterBtn3 == true)
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: FutureBuilder<List<Order>>(
                          future: orderPvd.getOrdersAsSenderOrReceiver(
                              user, 'sender', 'COMPLETE'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Order> orders = snapshot.data;
                              return ListView.builder(
                                itemCount: orders.length,
                                itemBuilder: (context, i) => UserOrderItem(
                                  orders[i].orderId,
                                  // SENDER DETAILS
                                  orders[i].orderSenderName,
                                  orders[i].orderSenderCity,
                                  orders[i].orderSenderAddress,
                                  orders[i].orderSenderDistrict,
                                  orders[i].orderSenderContact,
                                  // RECEIVER DETAILS
                                  orders[i].orderRecieverName,
                                  orders[i].orderRecieverCity,
                                  orders[i].orderRecieverAddress,
                                  orders[i].orderRecieverDistrict,
                                  orders[i].orderRecieverContact,
                                  // EXTRA DETAILS
                                  orders[i].orderDate,
                                  orders[i].orderPickupTime,
                                  orders[i].orderPackaging,
                                  orders[i].orderFragile,
                                  orders[i].orderPayer,
                                  orders[i].orderCollectionCash,
                                  orders[i].orderRefNo,
                                  orders[i].orderStatus,
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
                      )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchByMobile(BuildContext context, orderPvd, user) {
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
        _mobileNoValue = '966$text';
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => _mobileNoValue = '966$value',
      decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
    );

    final trackingNo = TextFormField(
      // validator: (value) => value.isEmpty ? "Please enter tracking no" : null,
      onSaved: (value) => _trackingNoValue = value,
      keyboardType: TextInputType.number,
      decoration:
          buildTextFieldInputDecoration('Tracking no', Icons.track_changes),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: trackingNo,
            ),
            const SizedBox(height: 13),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                orderPvd.getSearchOrderByMobile(
                    context, user, _mobileNoValue, _trackingNoValue);
              },
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _filterBtn(
      BuildContext context,
      filterTitle1,
      filterTitle2,
      filterTitle3,
      filterTitle4,
      filterBtn1,
      filterBtn2,
      filterBtn3,
      filterBtn4,
      activateOrderFilterBtn1,
      activateOrderFilterBtn2,
      activateOrderFilterBtn3,
      activateOrderFilterBtn4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 74,
          child: RaisedButton(
            elevation: 0,
            onPressed: () {
              activateOrderFilterBtn1();
            },
            child: Text(
              '$filterTitle1',
              style: TextStyle(
                color:
                    filterBtn1 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn1 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Container(
          width: 80,
          child: RaisedButton(
            padding: const EdgeInsets.all(0),
            elevation: 0,
            onPressed: () {
              activateOrderFilterBtn2();
            },
            child: Text(
              '$filterTitle2',
              style: TextStyle(
                color:
                    filterBtn2 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn2 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Container(
          width: 66,
          child: RaisedButton(
            padding: const EdgeInsets.all(0),
            elevation: 0,
            onPressed: () {
              activateOrderFilterBtn3();
            },
            child: Text(
              '$filterTitle3',
              style: TextStyle(
                color:
                    filterBtn3 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn3 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Container(
          width: 62,
          child: RaisedButton(
            padding: const EdgeInsets.all(0),
            elevation: 0,
            onPressed: () {
              activateOrderFilterBtn4();
            },
            child: Text(
              '$filterTitle4',
              style: TextStyle(
                color:
                    filterBtn4 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            color: filterBtn4 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
