import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/balance.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class CODAmountScreen extends StatefulWidget {
  static const String routeName = '/cod-amount';
  @override
  _CODAmountScreenState createState() => _CODAmountScreenState();
}

class _CODAmountScreenState extends State<CODAmountScreen> {
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final userPvd = Provider.of<UserProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('COD Amount'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: FutureBuilder<List<Balance>>(
          future: userPvd.getbalance(authPvd.user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Balance> balance = snapshot.data;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Amount waiting transfer'),
                          Text('${balance[0].balance}'),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text('Amount of shipment \n    did not deliver'),
                          Text('${balance[0].pending}'),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('Last one transections 27'),
                          Text('${balance[0].lastTransaction}'),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text('Balance is ready for withdraw'),
                          Text('${balance[0].pending}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(width: 1, color: Colors.grey),
                      ),
                    ),
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('25'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('800'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('type'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('amount'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6, bottom: 6),
                              child: Text('date'),
                            ),
                          ],
                        ),
                        // TableRow(
                        //   children: [
                        //     Text('    1'),
                        //     Text('    2'),
                        //     Text('    3'),
                        //     Text('    4'),
                        //     Padding(
                        //       padding: EdgeInsets.only(bottom: 8),
                        //       child: Text('25 Mar'),
                        //     ),
                        //   ],
                        // ),

                        ...(balance)[0].transactions.map(
                              (e) => TableRow(
                                children: [
                                  Text('${e.id}'),
                                  Text('${e.orderid}'),
                                  Text('${e.type}'),
                                  Text('${e.amount}'),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                        '${e.datetime.year} ${e.datetime.month} ${e.datetime.day}'),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }
}
