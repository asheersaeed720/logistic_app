import 'package:flutter/material.dart';

class AddOrderScreen extends StatefulWidget {
  static const String routeName = '/add-order';

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // PROPERTY NAME
    final fullNameField = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Theme.of(context).accentColor,
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

    final districtField = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Theme.of(context).accentColor,
          filled: true,
          labelText: 'District',
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

    final cityField = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Theme.of(context).accentColor,
          filled: true,
          labelText: 'City',
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

    // ADDRESS NAME
    final mobileField = Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Theme.of(context).accentColor,
          filled: true,
          labelText: 'Mobile No',
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        ),
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please type a address';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            // propertyData.address = value;
          });
        },
      ),
    );

    //ADD PROPERTY BTN
    final propertyButton = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            // propertyPvd.addProperty(
            //     context, propertyData, authPvd.token, authPvd.userId);
            // print(user);
            // propertyPvd.addProperty(context, user, propertyData);
          }
        },
        child: Text(
          'ADD ORDER',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.1,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Order'),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Image.asset(
                  //   './assets/images/logo.png',
                  //   width: 180,
                  // ),

                  SizedBox(height: 25),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    elevation: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Sender Address',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(height: 20),
                          fullNameField,
                          SizedBox(height: 20),
                          districtField,
                          SizedBox(height: 20),
                          cityField,
                          SizedBox(height: 20),
                          mobileField,
                          SizedBox(height: 20),
                          CheckboxListTile(
                            checkColor: Colors.white,
                            activeColor: Colors.blue,
                            title: Text("Save Address for future use"),
                            value: true,
                            onChanged: (newValue) {
                              setState(() {});
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          RadioListTile(
                            value: true,
                            groupValue: '1',
                            title: Text('From 9 to 12'),
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (currentVal) {},
                          ),
                          RadioListTile(
                            value: true,
                            groupValue: '2',
                            title: Text('From 12 to 3'),
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (currentVal) {},
                          ),
                          RadioListTile(
                            value: true,
                            groupValue: '4',
                            title: Text('From 3 to 6'),
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (currentVal) {},
                          ),
                          SizedBox(height: 20),
                          propertyButton,
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
