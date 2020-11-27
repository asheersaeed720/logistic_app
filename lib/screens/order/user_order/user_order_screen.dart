import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/filter_btn.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:provider/provider.dart';

class UserOrderScreen extends StatefulWidget {
  static const String routeName = '/user-order';

  @override
  _UserOrderScreenState createState() => _UserOrderScreenState();
}

class _UserOrderScreenState extends State<UserOrderScreen> {
  String _mobileNo, _trackingNo;

  @override
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);

    List orderList = [
      {
        "order_id": "9",
        "order_user_id": "28",
        "order_first_name": "test1",
        "order_lastname": "tester",
        "order_email": null,
        "order_contact": "123456789",
        "order_country": null,
        "order_city": "12457",
        "order_address": "central khi",
        "order_amount": "1000",
        "order_shipping": "200",
        "order_total_amount": "3000",
        "order_status": "PROCESSING",
        "order_date": "2020-11-27 09:39:44"
      },
      {
        "order_id": "10",
        "order_user_id": "28",
        "order_first_name": "test1",
        "order_lastname": "tester",
        "order_email": null,
        "order_contact": "123456789",
        "order_country": null,
        "order_city": "12457",
        "order_address": "central khi",
        "order_amount": "1000",
        "order_shipping": "200",
        "order_total_amount": "3000",
        "order_status": "PROCESSING",
        "order_date": "2020-11-27 09:40:00"
      },
      {
        "order_id": "11",
        "order_user_id": "28",
        "order_first_name": "test1",
        "order_lastname": "tester",
        "order_email": null,
        "order_contact": "123456789",
        "order_country": null,
        "order_city": "12457",
        "order_address": "central khi",
        "order_amount": "1000",
        "order_shipping": "200",
        "order_total_amount": "3000",
        "order_status": "PROCESSING",
        "order_date": "2020-11-27 09:40:52"
      },
      {
        "order_id": "12",
        "order_user_id": "28",
        "order_first_name": "test1",
        "order_lastname": "tester",
        "order_email": null,
        "order_contact": "123456789",
        "order_country": null,
        "order_city": "12457",
        "order_address": "central khi",
        "order_amount": "1000",
        "order_shipping": "200",
        "order_total_amount": "3000",
        "order_status": "PROCESSING",
        "order_date": "2020-11-27 09:41:42"
      },
      {
        "order_id": "13",
        "order_user_id": "28",
        "order_first_name": "test1",
        "order_lastname": "tester",
        "order_email": null,
        "order_contact": "123456789",
        "order_country": null,
        "order_city": "12457",
        "order_address": "central khi",
        "order_amount": "1000",
        "order_shipping": "200",
        "order_total_amount": "3000",
        "order_status": "PROCESSING",
        "order_date": "2020-11-27 09:42:00"
      },
      {
        "order_id": "14",
        "order_user_id": "28",
        "order_first_name": "test1",
        "order_lastname": "tester",
        "order_email": null,
        "order_contact": "123456789",
        "order_country": null,
        "order_city": "12457",
        "order_address": "central khi",
        "order_amount": "1000",
        "order_shipping": "200",
        "order_total_amount": "3000",
        "order_status": "PROCESSING",
        "order_date": "2020-11-27 09:42:28"
      },
      {
        "order_id": "15",
        "order_user_id": "28",
        "order_first_name": "test1",
        "order_lastname": "tester",
        "order_email": null,
        "order_contact": "123456789",
        "order_country": null,
        "order_city": "12457",
        "order_address": "central khi",
        "order_amount": "1000",
        "order_shipping": "200",
        "order_total_amount": "3000",
        "order_status": "PROCESSING",
        "order_date": "2020-11-27 09:42:53"
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Column(
            children: [
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
              const SizedBox(height: 14),
              if (filterPvd.orderFilterBtn1 == true)
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderList.length,
                        itemBuilder: (context, i) {
                          return Text('${orderList[i]}');
                        },
                      ),
                    ),
                  ],
                )
              else if (filterPvd.orderFilterBtn2 == true)
                Column(
                  children: [
                    HeadingTitle('Search by Mobile & Tracking no'),
                    const SizedBox(height: 22),
                    _buildSearchByMobile(context),
                  ],
                )
              else if (filterPvd.orderFilterBtn3 == true)
                Column(
                  children: [
                    HeadingTitle('Receiver'),
                    FilterBtn(
                      'New orders (1)',
                      'Not delivered (4)',
                      'Finished orders \n           (0)',
                      filterPvd.orderStatusFilterBtn1,
                      filterPvd.orderStatusFilterBtn2,
                      filterPvd.orderStatusFilterBtn3,
                      filterPvd.activateOrderStatusFilterBtn1,
                      filterPvd.activateOrderStatusFilterBtn2,
                      filterPvd.activateOrderStatusFilterBtn3,
                    ),
                  ],
                )
              else if (filterPvd.orderFilterBtn4 == true)
                Column(
                  children: [
                    HeadingTitle('Sender'),
                    FilterBtn(
                      'New orders (1)',
                      'Not delivered (4)',
                      'Finished orders \n           (0)',
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

  Widget _buildSearchByMobile(BuildContext context) {
    final mobileField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter Mobile" : null,
      onSaved: (value) => _mobileNo = value,
      keyboardType: TextInputType.phone,
      decoration: buildTextFieldInputDecoration('Mobile', Icons.phone),
    );

    final trackingNo = TextFormField(
        validator: (value) => value.isEmpty ? "Please enter Mobile" : null,
        onSaved: (value) => _trackingNo = value,
        keyboardType: TextInputType.number,
        decoration:
            buildTextFieldInputDecoration('Tracking no', Icons.track_changes));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mobileField,
          const SizedBox(height: 10),
          trackingNo,
          const SizedBox(height: 10),
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
