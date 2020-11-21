import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:provider/provider.dart';

class OrderSuccess extends StatelessWidget {
  static const String routeName = '/order-success';

  @override
  Widget build(BuildContext context) {
    final tabPvd = Provider.of<TabProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 36, right: 10, left: 10, bottom: 10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Center(
                child: Text(
                  'Your Order No: 213646',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width / 1,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Customer Unique number',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'F43646',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 6),
                    child: Column(
                      children: [
                        Text('Receiver Name'),
                        Text('City'),
                        Text('Country'),
                        Text('Mobile No'),
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
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    child: Column(
                      children: [
                        Text('Sender Name'),
                        Text('City'),
                        Text('Country'),
                        Text('Mobile No'),
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
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
