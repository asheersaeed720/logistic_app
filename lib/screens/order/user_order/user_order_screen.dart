import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';

class UserOrderScreen extends StatefulWidget {
  static const String routeName = '/user-order';

  @override
  _UserOrderScreenState createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _mobileNo, _trackingNo;

  @override
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);
    final orderPvd = Provider.of<OrderProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
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
                    future: orderPvd.getUserOrder(user),
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
                          child: Text(
                            "${getTranslatedValue(context, 'no_order_found')}",
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
                    FilterBtn(
                      // 'New orders (1)',
                      // 'Not delivered (4)',
                      // 'Finished orders \n           (0)',
                      "${getTranslatedValue(context, 'new_orders')}",
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
                          future:
                              orderPvd.getFilterUserOrder(user, 'PROCESSING'),
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
                                child: Text(
                                  // 'No Order Found!',
                                  "${getTranslatedValue(context, 'no_order_found')}",
                                ),
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
                          future: orderPvd.getFilterUserOrder(user, 'PENDING'),
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
                                child: Text(
                                  // 'No Order Found!',
                                  "${getTranslatedValue(context, 'no_order_found')}",
                                ),
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
                          future: orderPvd.getFilterUserOrder(user, 'COMPLETE'),
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
                                child: Text(
                                  // 'No Order Found!',
                                  "${getTranslatedValue(context, 'no_order_found')}",
                                ),
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
                    FilterBtn(
                      // 'New orders (1)',
                      // 'Not delivered (4)',
                      // 'Finished orders \n           (0)',
                      "${getTranslatedValue(context, 'new_orders')}",
                      "${getTranslatedValue(context, 'not_delivered')}",
                      "${getTranslatedValue(context, 'finished_orders')}",
                      filterPvd.orderStatusFilterBtn1,
                      filterPvd.orderStatusFilterBtn2,
                      filterPvd.orderStatusFilterBtn3,
                      filterPvd.activateOrderStatusFilterBtn1,
                      filterPvd.activateOrderStatusFilterBtn2,
                      filterPvd.activateOrderStatusFilterBtn3,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchByMobile(BuildContext context, orderPvd, user) {
    final mobileField = TextFormField(
      // validator: (value) => value.isEmpty ? "Please enter Mobile no" : null,
      onSaved: (value) => _mobileNo = '966$value',
      keyboardType: TextInputType.phone,
      decoration: buildTextFieldInputDecoration('Mobile', Icons.phone),
    );

    final trackingNo = TextFormField(
        // validator: (value) => value.isEmpty ? "Please enter tracking no" : null,
        onSaved: (value) => _trackingNo = value,
        keyboardType: TextInputType.number,
        decoration:
            buildTextFieldInputDecoration('Tracking no', Icons.track_changes));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mobileField,
            const SizedBox(height: 10),
            trackingNo,
            const SizedBox(height: 10),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  orderPvd.getUserOrderByMobile(user, _mobileNo, _trackingNo);
                }
              },
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            )
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
          width: 68,
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
          width: 90,
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
          width: 60,
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
          width: 60,
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
