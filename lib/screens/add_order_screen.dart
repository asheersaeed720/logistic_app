import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
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

    final fullNameField = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          labelText: 'Full Name',
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        ),
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please type a property name';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            // propertyData.name = value;
          });
        },
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(context, 'Sender Address'),
              SizedBox(height: 10),
              _filterBtn(
                context,
                orderPvd.activeFilterBtn1,
                orderPvd.activeFilterBtn2,
                orderPvd.activeFilterBtn3,
                orderPvd.getDataFromActivatedFilterBtn1,
                orderPvd.getDataFromActivatedFilterBtn2,
                orderPvd.getDataFromActivatedFilterBtn3,
                'Saved Addresses',
                'New Address',
                'My address',
              ),
              if (orderPvd.activeFilterBtn1 == true)
                Text('Saved Addresses')
              else if (orderPvd.activeFilterBtn2 == true)
                Text('New Address')
              else if (orderPvd.activeFilterBtn3 == true)
                Text('My address'),
              SizedBox(height: 20),
              _buildHeader(context, 'Pickup Prefer Time'),
              SizedBox(height: 20),
              _filterBtn(
                context,
                orderPvd.activeFilter2Btn1,
                orderPvd.activeFilter2Btn2,
                orderPvd.activeFilter2Btn3,
                orderPvd.getDataFromActivatedFilter2Btn1,
                orderPvd.getDataFromActivatedFilter2Btn2,
                orderPvd.getDataFromActivatedFilter2Btn3,
                'Pickup time from sender',
                'Example',
                'Ask',
              ),
              SizedBox(height: 20),
              if (orderPvd.activeFilter2Btn1 == true)
                Text('Pickup time from sender')
              else if (orderPvd.activeFilter2Btn2 == true)
                Text('Example')
              else if (orderPvd.activeFilter2Btn3 == true)
                Text('Ask'),
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
          style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2),
        ),
      ),
    );
  }

  Widget _filterBtn(
    BuildContext context,
    activeFilterBtn1,
    activeFilterBtn2,
    activeFilterBtn3,
    getDataFromActivatedFilterBtn1,
    getDataFromActivatedFilterBtn2,
    getDataFromActivatedFilterBtn3,
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
            getDataFromActivatedFilterBtn1();
          },
          child: Text(
            '$filterTitle1',
            style: activeFilterBtn1
                ? TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          color:
              activeFilterBtn1 ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        RaisedButton(
          elevation: 0,
          splashColor: Colors.white,
          onPressed: () {
            getDataFromActivatedFilterBtn2();
          },
          child: Text(
            '$filterTitle2',
            style: activeFilterBtn2
                ? TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          color:
              activeFilterBtn2 ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        RaisedButton(
          elevation: 0,
          splashColor: Colors.white,
          onPressed: () {
            getDataFromActivatedFilterBtn3();
          },
          child: Text(
            '$filterTitle3',
            style: activeFilterBtn3
                ? TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                : TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
          ),
          color:
              activeFilterBtn3 ? Theme.of(context).primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
