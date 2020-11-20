import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/add_order_screen.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';

class UserOrderScreen extends StatelessWidget {
  static const String routeName = '/user-order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          title: Column(
            children: [
              SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Delivery Outside Riyadh \n                 50',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  Text(
                    'Price for Delivery Inside \n                 35',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
              // SizedBox(height: 8),
              // Text(
              //   'Note: Warning that prices not including VAT',
              //   style: TextStyle(color: Colors.red, fontSize: 15.0),
              // ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text(
                'Total Amount: 500',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Active'),
              trailing: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text(
                  'VIEW',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Total Amount: 1000',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Pending'),
              trailing: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text(
                  'VIEW',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Total Amount: 450',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Cancelled'),
              trailing: FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text(
                  'VIEW',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
