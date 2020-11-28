import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:provider/provider.dart';

class SenderAddresses extends StatefulWidget {
  static const String routeName = '/sender-addresses';

  @override
  _SenderAddressesState createState() => _SenderAddressesState();
}

class _SenderAddressesState extends State<SenderAddresses> {
  final _formKey = new GlobalKey<FormState>();

  Address _address = Address();

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);

    final senderName = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your fullname" : null,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _address.senderName = value,
      decoration: buildTextFieldInputDecoration("fullname", Icons.person),
    );

    final senderCitiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel val) {
        _address.senderCity = val;
        print(_address.senderCity);
      },
      validator: (value) => _address.senderCity == null ? 'Select city' : null,
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final senderDistrict = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your district" : null,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) => _address.senderName = value,
      decoration: buildTextFieldInputDecoration("District", Icons.location_on),
    );

    final senderMobileNo = TextFormField(
      validator: (value) =>
          value.isEmpty ? "Please enter your mobile no" : null,
      keyboardType: TextInputType.number,
      onSaved: (value) => _address.senderName = value,
      decoration: buildTextFieldInputDecoration("Mobile no", Icons.phone),
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Column(
          children: [
            Card(
              elevation: 1,
              child: ListTile(
                title: Text('Farzana Khan'),
                subtitle: Text('Al-Madina'),
                trailing: Text('5482165468'),
              ),
            ),
            Card(
              elevation: 1,
              child: ListTile(
                title: Text('Zain Chugtai'),
                subtitle: Text('Al-riyadh'),
                trailing: Text('5482165568'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          senderName,
                          SizedBox(height: 10),
                          senderCitiesDropdown,
                          SizedBox(height: 10),
                          senderDistrict,
                          SizedBox(height: 10),
                          senderMobileNo,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                  }
                                },
                                child: Text(
                                  "Add Address",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _customDropDownExample(
      BuildContext context, SearchCityModel item, String itemDesignation) {
    return Container(
      // padding: EdgeInsets.all(0),
      height: 28,
      child: (item?.name == null)
          ? Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('Select City'),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 6),
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
}
