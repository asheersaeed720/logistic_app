import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/address_filter_data/new_address_form.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/address_filter_data/time_radio_btn.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  static const String routeName = '/add-order';

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);

    final cashOfDeliveryAmount = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter amount" : null,
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      initialValue: '0',
      decoration: buildInputDecoration('Amount', Icons.money),
    );

    final referenceNo = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter ref no" : null,
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration('Ref No', Icons.tag),
    );

    final dummyCeckBox1 = CheckboxListTile(
      title: Text("Packaging their items with us"),
      value: true,
      onChanged: (newVal) {
        print(newVal);
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    final dummyCeckBox2 = CheckboxListTile(
      title: Text("Adding a fragile sticker to their item"),
      value: true,
      onChanged: (newVal) {
        print(newVal);
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // SENDER ADDRESS FILTER
              SizedBox(height: 20),
              _buildHeader(context, 'Sender Address'),
              SizedBox(height: 10),
              _filterBtn(
                context,
                orderPvd.addressFilterBtn1,
                orderPvd.addressFilterBtn2,
                orderPvd.addressFilterBtn3,
                orderPvd.activateAddressFilterBtn1,
                orderPvd.activateAddressFilterBtn2,
                orderPvd.activateAddressFilterBtn3,
                'Saved Addresses',
                'New Address',
                'My address',
              ),
              if (orderPvd.addressFilterBtn1 == true)
                Column(
                  children: [
                    ListTile(
                      leading: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.person),
                      ),
                      title: Text('Person name 1'),
                      subtitle: Text('City Name & Number 1'),
                    ),
                    Divider(),
                    ListTile(
                      leading: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.person),
                      ),
                      title: Text('Person name 2'),
                      subtitle: Text('City Name & Number 2'),
                    ),
                  ],
                )
              else if (orderPvd.addressFilterBtn2 == true)
                NewAddressForm()
              else if (orderPvd.addressFilterBtn3 == true)
                Text(''),
              SizedBox(height: 20),

              // TIME FILTER
              _buildHeader(context, 'Pickup Prefer Time'),
              SizedBox(height: 20),
              _filterBtn(
                context,
                orderPvd.timeFilterBtn1,
                orderPvd.timeFilterBtn2,
                orderPvd.timeFilterBtn3,
                orderPvd.activateTimeFilterBtn1,
                orderPvd.activateTimeFilterBtn2,
                orderPvd.activateTimeFilterBtn3,
                'Tomorrow',
                'Today',
                'Nearest',
              ),
              SizedBox(height: 20),
              if (orderPvd.timeFilterBtn1 == true)
                TimeRadioBtn()
              else if (orderPvd.timeFilterBtn2 == true)
                TimeRadioBtn()
              else if (orderPvd.timeFilterBtn3 == true)
                Text(''),
              SizedBox(height: 20),
              _buildHeader(context, 'Receiver Address'),
              SizedBox(height: 20),

              // RECEIVER ADDRESS
              _filterBtn(
                context,
                orderPvd.receiverAddressFilterBtn1,
                orderPvd.receiverAddressFilterBtn2,
                orderPvd.receiverAddressFilterBtn3,
                orderPvd.activateReceiverAddressFilterBtn1,
                orderPvd.activateReceiverAddressFilterBtn2,
                orderPvd.activateReceiverAddressFilterBtn3,
                'Saved Addresses',
                'New Address',
                'My address',
              ),
              if (orderPvd.receiverAddressFilterBtn1 == true)
                Column(
                  children: [
                    ListTile(
                      leading: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.person),
                      ),
                      title: Text('Person name 1'),
                      subtitle: Text('City Name & Number 1'),
                    ),
                    Divider(),
                    ListTile(
                      leading: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.person),
                      ),
                      title: Text('Person name 2'),
                      subtitle: Text('City Name & Number 2'),
                    ),
                  ],
                )
              else if (orderPvd.receiverAddressFilterBtn2 == true)
                NewAddressForm()
              else if (orderPvd.receiverAddressFilterBtn3 == true)
                Text(''),
              SizedBox(height: 20),
              _buildHeader(context, 'Collecting Cash from Receiver'),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: cashOfDeliveryAmount,
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Note: if this amount is collected we will need to add it to the customer profile. Also, it will be cleared by ADMIN.',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
              SizedBox(height: 20),
              _buildHeader(context, 'Extra Info “Not Mandatory”'),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: referenceNo,
              ),
              SizedBox(height: 20),
              dummyCeckBox1,
              dummyCeckBox2,
              SizedBox(height: 20),
            ],
          ),
        ),
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
            fontSize: 18,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _filterBtn(
    BuildContext context,
    filterBtn1,
    filterBtn2,
    filterBtn3,
    activateFilterBtn1,
    activateFilterBtn2,
    activateFilterBtn3,
    filterTitle1,
    filterTitle2,
    filterTitle3,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          elevation: 0,
          splashColor: Colors.white,
          onPressed: () {
            activateFilterBtn1();
          },
          child: Text(
            '$filterTitle1',
            style: filterBtn1
                ? TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          color: filterBtn1 ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        RaisedButton(
          elevation: 0,
          splashColor: Colors.white,
          onPressed: () {
            activateFilterBtn2();
          },
          child: Text(
            '$filterTitle2',
            style: filterBtn2
                ? TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          color: filterBtn2 ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        RaisedButton(
          elevation: 0,
          splashColor: Colors.white,
          onPressed: () {
            activateFilterBtn3();
          },
          child: Text(
            '$filterTitle3',
            style: filterBtn3
                ? TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          color: filterBtn3 ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
