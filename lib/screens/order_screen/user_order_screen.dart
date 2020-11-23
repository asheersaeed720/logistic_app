import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/add_order_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class UserOrderScreen extends StatelessWidget {
  static const String routeName = '/user-order';

  @override
  // Widget build(BuildContext context) {
  // return Scaffold(
  //   appBar: PreferredSize(
  //     preferredSize: Size.fromHeight(65.0),
  //     child: AppBar(
  //       title: Column(
  //         children: [
  //           SizedBox(height: 8),

  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               Text(
  //                 'Delivery Outside Riyadh \n                 50',
  //                 style: TextStyle(fontSize: 13.0),
  //               ),
  //               Text(
  //                 'Price for Delivery Inside \n                 35',
  //                 style: TextStyle(fontSize: 13.0),
  //               ),
  //             ],
  //           ),
  //           // SizedBox(height: 8),
  //           // Text(
  //           //   'Note: Warning that prices not including VAT',
  //           //   style: TextStyle(color: Colors.red, fontSize: 15.0),
  //           // ),
  //         ],
  //       ),
  //       automaticallyImplyLeading: false,
  //     ),
  //   ),
  //   body: Column(
  //     children: [
  //       Card(
  //         child: ListTile(
  //           title: Text(
  //             'Total Amount: 500',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           subtitle: Text('Active'),
  //           trailing: FlatButton(
  //             color: Theme.of(context).primaryColor,
  //             onPressed: () {},
  //             child: Text(
  //               'VIEW',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Card(
  //         child: ListTile(
  //           title: Text(
  //             'Total Amount: 1000',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           subtitle: Text('Pending'),
  //           trailing: FlatButton(
  //             color: Theme.of(context).primaryColor,
  //             onPressed: () {},
  //             child: Text(
  //               'VIEW',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Card(
  //         child: ListTile(
  //           title: Text(
  //             'Total Amount: 450',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           subtitle: Text('Cancelled'),
  //           trailing: FlatButton(
  //             color: Theme.of(context).primaryColor,
  //             onPressed: () {},
  //             child: Text(
  //               'VIEW',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // );
// }
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);
    final orderPvd = Provider.of<OrderProvider>(context);

    final mobileField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter Mobile" : null,
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      initialValue: '0',
      decoration: buildInputDecoration('Amount', Icons.money),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // _buildHeader(context, 'Sender Address'),
              SizedBox(height: 10),
              _filterBtn(
                context,
                '  All Order',
                'Mobile no',
                'Receiver',
                'Sender',
                filterPvd.orderFilterBtn1,
                filterPvd.orderFilterBtn2,
                filterPvd.orderFilterBtn3,
                filterPvd.orderFilterBtn4,
                filterPvd.activateOrderFilterBtn1,
                filterPvd.activateOrderFilterBtn2,
                filterPvd.activateOrderFilterBtn3,
                filterPvd.activateOrderFilterBtn4,
              ),

//
              SizedBox(height: 14),
              if (filterPvd.orderFilterBtn1 == true)
                Text('All Order Activated')
              else if (filterPvd.orderFilterBtn2 == true)
                Column(
                  children: [
                    _buildHeader(context, 'Mobile no'),
                    SizedBox(height: 12),
                    _buildSearchByMobile(context),
                  ],
                )
              else if (filterPvd.orderFilterBtn3 == true)
                Column(
                  children: [
                    _buildHeader(context, 'Receiver'),
                    SizedBox(height: 12),
                    _orderStatusFilterBtn(
                      context,
                      'New orders (1)',
                      'Not delivered (4)',
                      'Finished orders \n           (0)',
                      filterPvd.orderStatusFilterBtn1,
                      filterPvd.orderStatusFilterBtn2,
                      filterPvd.orderStatusFilterBtn3,
                      filterPvd.activateOrderStatusFilterBtn1,
                      filterPvd.activateOrderStatusFilterBtn2,
                      filterPvd.activateOrderStatusFilterBtn3,
                    )
                  ],
                )
              else if (filterPvd.orderFilterBtn4 == true)
                Column(
                  children: [
                    _buildHeader(context, 'Sender'),
                    SizedBox(height: 12),
                    _orderStatusFilterBtn(
                      context,
                      'New orders (1)',
                      'Not delivered (4)',
                      'Finished orders \n           (0)',
                      filterPvd.orderStatusFilterBtn1,
                      filterPvd.orderStatusFilterBtn2,
                      filterPvd.orderStatusFilterBtn3,
                      filterPvd.activateOrderStatusFilterBtn1,
                      filterPvd.activateOrderStatusFilterBtn2,
                      filterPvd.activateOrderStatusFilterBtn3,
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchByMobile(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            autofocus: false,
            validator: (value) => value.isEmpty ? "Please enter Mobile" : null,
            // onSaved: (value) => _name = value,
            keyboardType: TextInputType.name,
            decoration: buildInputDecoration('Mobile', Icons.phone),
          ),
          SizedBox(height: 10),
          TextFormField(
            autofocus: false,
            validator: (value) => value.isEmpty ? "Please enter Mobile" : null,
            // onSaved: (value) => _name = value,
            keyboardType: TextInputType.name,
            decoration: buildInputDecoration(
                'Tracking no.', Icons.track_changes_outlined),
          ),
          SizedBox(height: 10),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {},
            child: Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, headerTitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
      width: MediaQuery.of(context).size.width / 1,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        gradient: new LinearGradient(
          colors: [
            CustomColor.gradientEnd,
            CustomColor.gradientStart,
          ],
          begin: const FractionalOffset(0.2, 0.2),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Center(
        child: Text(
          headerTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.5,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
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
    activateOrderFilterBtn4,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 68,
          child: RaisedButton(
            // padding: EdgeInsets.all(0),
            elevation: 0,
            splashColor: Colors.white,
            onPressed: () {
              activateOrderFilterBtn1();
            },
            child: Text(
              '$filterTitle1',
              // style: filterBtn1
              //     ? TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 11)
              //     : TextStyle(
              //         color: Theme.of(context).primaryColor,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 11),
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
            padding: EdgeInsets.all(0),
            elevation: 0,
            splashColor: Colors.white,
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
            padding: EdgeInsets.all(0),
            elevation: 0,
            splashColor: Colors.white,
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
            padding: EdgeInsets.all(0),
            elevation: 0,
            splashColor: Colors.white,
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

  Widget _orderStatusFilterBtn(
    BuildContext context,
    filterTitle1,
    filterTitle2,
    filterTitle3,
    filterBtn1,
    filterBtn2,
    filterBtn3,
    activateOrderFilterBtn1,
    activateOrderFilterBtn2,
    activateOrderFilterBtn3,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 110,
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            elevation: 0,
            splashColor: Colors.white,
            onPressed: () {
              activateOrderFilterBtn1();
            },
            child: Text(
              '$filterTitle1',
              // style: filterBtn1
              //     ? TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 11)
              //     : TextStyle(
              //         color: Theme.of(context).primaryColor,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 11),
              style: TextStyle(
                color:
                    filterBtn1 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            color: filterBtn1 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Container(
          width: 120,
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            elevation: 0,
            splashColor: Colors.white,
            onPressed: () {
              activateOrderFilterBtn2();
            },
            child: Text(
              '$filterTitle2',
              style: TextStyle(
                color:
                    filterBtn2 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            color: filterBtn2 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Container(
          width: 110,
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            elevation: 0,
            splashColor: Colors.white,
            onPressed: () {
              activateOrderFilterBtn3();
            },
            child: Text(
              '$filterTitle3',
              style: TextStyle(
                color:
                    filterBtn3 ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            color: filterBtn3 ? Theme.of(context).primaryColor : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
