import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/services/web_api.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/filter_btn.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/radio_btn.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:searchable_dropdown/searchable_dropdown.dart';

class FormOneWidget extends StatefulWidget {
  @override
  _FormOneWidgetState createState() => _FormOneWidgetState();
}

class _FormOneWidgetState extends State<FormOneWidget> {
  final _formKey = GlobalKey<FormState>();

  String _fullName, _city, _district, _mobileNo;

  List<String> countries = new List();

  Address _address = Address();

  Future<List> getServerData() async {
    String url = 'https://restcountries.eu/rest/v2/all';
    final response =
        await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> responseBody = json.decode(response.body);
      // List<String> countries = new List();
      countries = new List();
      for (int i = 0; i < responseBody.length; i++) {
        countries.add(responseBody[i]['name']);
      }
      return countries;
    } else {
      print("error from server : $response");
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    getServerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);
    final orderPvd = Provider.of<OrderProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SENDER ADDRESS SECTION
                _buildSenderAddressSection(context, filterPvd, orderPvd),

                // TIME SECTION
                _buildTimeSection(context, filterPvd),

                // RECEIVER ADDRESS SECTION
                _buildReceiverSection(context, filterPvd),

                // CASH FROM RECEIVER SECTION
                _buildCashFromReceiverSection(context),

                // EXTRA INFO SECTION
                _buildExtraInfoSection(context),

                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Next >',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      print(_address);
                      orderPvd.formNavigation();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchableDropdown(List<String> listData, mapKey) {
    Map<String, String> selectedValueMap = Map();

    List<DropdownMenuItem> items = [];
    for (int i = 0; i < listData.length; i++) {
      items.add(new DropdownMenuItem(
        child: new Text(
          listData[i],
        ),
        value: listData[i],
      ));
    }

    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 10.0),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(6.0),
    //     border: Border.all(
    //         color: Colors.grey, style: BorderStyle.solid, width: 0.80),
    //   ),
    //   width: 400,
    //   child: SearchableDropdown(
    //     items: items,
    //     value: selectedValueMap[mapKey],
    //     isCaseSensitiveSearch: false,
    //     hint: new Text('Select One'),
    //     searchHint: new Text(
    //       'Select One',
    //       style: new TextStyle(fontSize: 20),
    //     ),
    //     onChanged: (value) {
    //       setState(() {
    //         selectedValueMap[mapKey] = value;
    //       });
    //     },
    //   ),
    // );
    return Container(
      padding: EdgeInsets.all(0.0),
      height: 70.0,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SearchableDropdown(
        items: items,
        value: selectedValueMap[mapKey],
        isCaseSensitiveSearch: false,
        isExpanded: true,
        underline: Padding(
          padding: EdgeInsets.all(0),
        ),
        hint: new Text('Select One'),
        searchHint: new Text(
          'Select One',
          style: new TextStyle(fontSize: 20),
        ),
        onChanged: (value) {
          setState(() {
            selectedValueMap[mapKey] = value;
          });
        },
      ),
    );
  }

  // SENDER ADDRESS SECTION
  Widget _buildSenderAddressSection(context, filterPvd, orderPvd) {
    Map<String, String> selectedValueMap = Map();

    List<DropdownMenuItem> items = [];
    final fullNameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _address.senderName = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Fullname", Icons.person),
    );

    // final citiesSearchableDropDownField = SearchableDropdown(
    //   items: items,
    //   value: selectedValueMap['server'],
    //   isCaseSensitiveSearch: false,
    //   hint: new Text('Select One'),
    //   searchHint: new Text(
    //     'Select One',
    //     style: new TextStyle(fontSize: 20),
    //   ),
    //   onChanged: (value) {
    //     setState(() {
    //       selectedValueMap['server'] = value;
    //     });
    //   },
    // );

    final citiesSearchableDropDownField = SearchableDropdown(
      items: items,
      value: selectedValueMap['server'],
      isCaseSensitiveSearch: false,
      hint: new Text('Select One'),
      searchHint: new Text(
        'Select One',
        style: new TextStyle(fontSize: 20),
      ),
      onChanged: (value) {
        setState(() {
          selectedValueMap['server'] = value;
        });
      },
    );

    // final cityDropDownField = TextFormField(
    //   autofocus: false,
    //   validator: (value) => value.isEmpty ? "Please type a City" : null,
    //   onSaved: (value) => _address.senderCity = value,
    //   keyboardType: TextInputType.name,
    //   initialValue: 'Riyadh',
    //   decoration: buildDropDownDecoration(Icons.arrow_drop_down),
    // );

    final districtField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _address.senderDistrict = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildInputDecoration("District", Icons.location_on),
    );

    final mobileNoField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter mobile no" : null,
      onSaved: (value) => _address.senderMobileNo = value,
      keyboardType: TextInputType.number,
      decoration: buildInputDecoration("Mobile no", Icons.phone),
    );

    return Column(
      children: [
        HeadingTitle('Sender Address'),
        FilterBtn(
          'My address',
          'New Address',
          'Saved Addresses',
          filterPvd.addressFilterBtn1,
          filterPvd.addressFilterBtn2,
          filterPvd.addressFilterBtn3,
          filterPvd.activateAddressFilterBtn1,
          filterPvd.activateAddressFilterBtn2,
          filterPvd.activateAddressFilterBtn3,
        ),
        if (filterPvd.addressFilterBtn1 == true)
          Text(
            'Note: Your Default address which was submitted \n when you created account.',
            style: TextStyle(color: Theme.of(context).errorColor, fontSize: 15),
          )
        else if (filterPvd.addressFilterBtn2 == true)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                fullNameField,
                SizedBox(height: 14),
                FutureBuilder<List>(
                  future: orderPvd.getCities(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return getSearchableDropdown(snapshot.data, "server");
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // return CircularProgressIndicator();
                    return citiesSearchableDropDownField;
                  },
                ),
                SizedBox(height: 14),
                districtField,
                SizedBox(height: 14),
                mobileNoField,
              ],
            ),
          )
        else if (filterPvd.addressFilterBtn3 == true)
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
          ),
        SizedBox(height: 18),
      ],
    );
  }

  // TIME SECTION
  Widget _buildTimeSection(context, filterPvd) {
    return Column(
      children: [
        HeadingTitle('Pickup Prefer Time'),
        FilterBtn(
          'Nearest',
          'Today',
          'Tomorrow',
          filterPvd.timeFilterBtn1,
          filterPvd.timeFilterBtn2,
          filterPvd.timeFilterBtn3,
          filterPvd.activateTimeFilterBtn1,
          filterPvd.activateTimeFilterBtn2,
          filterPvd.activateTimeFilterBtn3,
        ),
        if (filterPvd.timeFilterBtn1 == true)
          Text(
            'Note: Nearest time',
            style: TextStyle(color: Theme.of(context).errorColor),
          )
        else if (filterPvd.timeFilterBtn2 == true)
          RadioBtn(
            'From 9 to 12',
            'From 12 to 3',
            'From 3 to 6',
          )
        else if (filterPvd.timeFilterBtn3 == true)
          RadioBtn(
            'From 9 to 12',
            'From 12 to 3',
            'From 3 to 6',
          ),
        SizedBox(height: 18),
      ],
    );
  }

  // RECEIVER SECTION
  Widget _buildReceiverSection(context, filterPvd) {
    final fullNameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type Receiver name" : null,
      onSaved: (value) => _fullName = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Receiver name", Icons.person),
    );

    final cityDropDownField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type a City" : null,
      onSaved: (value) => _city = value,
      keyboardType: TextInputType.name,
      initialValue: 'Riyadh',
      decoration: buildDropDownDecoration(Icons.arrow_drop_down),
    );

    final districtField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _district = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildInputDecoration("District", Icons.location_on),
    );

    final mobileNoField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter mobile no" : null,
      onSaved: (value) => _mobileNo = value,
      keyboardType: TextInputType.number,
      decoration: buildInputDecoration("Mobile no", Icons.phone),
    );

    return Column(
      children: [
        HeadingTitle('Receiver Address'),
        FilterBtn(
          'My address',
          'New Address',
          'Saved Addresses',
          filterPvd.receiverAddressFilterBtn1,
          filterPvd.receiverAddressFilterBtn2,
          filterPvd.receiverAddressFilterBtn3,
          filterPvd.activateReceiverAddressFilterBtn1,
          filterPvd.activateReceiverAddressFilterBtn2,
          filterPvd.activateReceiverAddressFilterBtn3,
        ),
        if (filterPvd.receiverAddressFilterBtn1 == true)
          Text(
            'Note: Address Receiver Address <add button soon>',
            style: TextStyle(color: Theme.of(context).errorColor, fontSize: 15),
          )
        else if (filterPvd.receiverAddressFilterBtn2 == true)
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                fullNameField,
                SizedBox(height: 14),
                cityDropDownField,
                SizedBox(height: 14),
                districtField,
                SizedBox(height: 14),
                mobileNoField,
              ],
            ),
          )
        else if (filterPvd.receiverAddressFilterBtn3 == true)
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
          ),
        SizedBox(height: 18),
      ],
    );
  }
}

// CASH FROM RECEIVER SECTION
Widget _buildCashFromReceiverSection(context) {
  final cashOfDeliveryAmount = TextFormField(
    autofocus: false,
    validator: (value) => value.isEmpty ? "Please enter amount" : null,
    // onSaved: (value) => _name = value,
    keyboardType: TextInputType.name,
    initialValue: '0',
    decoration: buildInputDecoration('Amount', Icons.money),
  );
  return Column(
    children: [
      HeadingTitle('Collecting Cash from Receiver'),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        child: cashOfDeliveryAmount,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          'Note: if this amount is collected we will need to add it to the customer profile. Also, it will be cleared by ADMIN.',
          style: TextStyle(color: Theme.of(context).errorColor),
        ),
      ),
      SizedBox(height: 18),
    ],
  );
}

// EXTRA INFO SECTION
Widget _buildExtraInfoSection(context) {
  final referenceNo = TextFormField(
    autofocus: false,
    // validator: (value) => value.isEmpty ? "Please enter ref no" : null,
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
  return Column(
    children: [
      HeadingTitle('Extra Info “Not Mandatory”'),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        child: referenceNo,
      ),
      dummyCeckBox1,
      dummyCeckBox2,
    ],
  );
}
