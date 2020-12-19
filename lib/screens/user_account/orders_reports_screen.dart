import 'package:flutter/material.dart';

class OrdersReportsScreen extends StatefulWidget {
  static const String routeName = '/orders-reports';
  @override
  _OrdersReportsScreenState createState() => _OrdersReportsScreenState();
}

class _OrdersReportsScreenState extends State<OrdersReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders Reports'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Amount waiting transfer'),
                    Text('0'),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text('Amount of shipment did not deliver'),
                    Text('500'),
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
                    Text('27 Nov    990'),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text('Balance is ready for withdraw'),
                    Text('0'),
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
                // defaultColumnWidth: FixedColumnWidth(100.0),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text('data 1'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text('data 2'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text('data 3'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text('data 4'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6, bottom: 6),
                        child: Text('Date'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text('    1'),
                      Text('    2'),
                      Text('    3'),
                      Text('    4'),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text('25 Mar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
