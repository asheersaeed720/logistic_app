import 'package:hani_almutairi_logistic/models/search_city.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/filter_btn.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/radio_btn.dart';
import 'package:provider/provider.dart';

class FormOneWidget extends StatefulWidget {
  @override
  _FormOneWidgetState createState() => _FormOneWidgetState();
}

class _FormOneWidgetState extends State<FormOneWidget> {
  final _formKey = GlobalKey<FormState>();

  String _fullName, _city, _district, _mobileNo;

  List<String> countries = new List();

  Address _address = Address();

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

                // SearchableDropdownWidget(),

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
                      print(_address.senderCity);
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

  // SENDER ADDRESS SECTION
  Widget _buildSenderAddressSection(context, filterPvd, orderPvd) {
    final fullNameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _address.senderName = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Fullname", Icons.person),
    );

    final citiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      // dropdownSearchDecoration: InputDecoration(
      //   filled: true,
      //   fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      // ),
      // autoValidateMode: AutovalidateMode.onUserInteraction,
      // validator: (SearchModel u) =>
      //     u == null ? "user field is required " : null,
      onFind: (String filter) => orderPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        _address.senderCity = data;
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

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
                citiesDropdown,
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

  Widget _customDropDownExample(
      BuildContext context, SearchCityModel item, String itemDesignation) {
    return Container(
      // padding: EdgeInsets.all(0),
      height: 28,
      child: (item?.name == null)
          ? Padding(
              padding: EdgeInsets.only(top: 7),
              child: Text('Select City'),
            )
          : Padding(
              padding: EdgeInsets.only(top: 7),
              child: Text(item.name),
            ),
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, SearchCityModel item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name),
      ),
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
