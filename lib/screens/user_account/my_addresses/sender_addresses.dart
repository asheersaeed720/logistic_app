import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

class SenderAddresses extends StatefulWidget {
  static const String routeName = '/sender-addresses';

  @override
  _SenderAddressesState createState() => _SenderAddressesState();
}

class _SenderAddressesState extends State<SenderAddresses> {
  final _formKey = new GlobalKey<FormState>();

  Address _address = Address();

  @override
  void didUpdateWidget(SenderAddresses oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);
    final userPvd = Provider.of<UserProvider>(context);

    final senderName = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your fullname" : null,
      keyboardType: TextInputType.name,
      onSaved: (value) => _address.senderName = value,
      decoration: buildTextFieldInputDecoration("Fullname", Icons.person),
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
      onSaved: (value) => _address.senderDistrict = value,
      decoration: buildTextFieldInputDecoration("District", Icons.location_on),
    );

    final senderAddress = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your address" : null,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) => _address.senderAddress = value,
      decoration: buildTextFieldInputDecoration("Address", Icons.location_on),
    );

    final countriesCodeField = TextFormField(
      initialValue: '966',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '966',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    final senderMobileNo = TextFormField(
      maxLength: 9,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a phone number';
        } else if (_address.senderMobileNo.length < 9) {
          return 'Invalid Number';
        }
        return null;
      },
      onChanged: (text) {
        _address.senderMobileNo = text;
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => _address.senderMobileNo = '966$value',
      decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: userPvd.isLoading
                ? LoadingIndicator()
                : FutureBuilder<List<UserAddress>>(
                    future: userPvd.getSenderAddresses(authPvd.user),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<UserAddress> userAddresses = snapshot.data;
                        return userAddresses.isEmpty
                            ? Center(
                                child: Text('No Sender Addresses Found'),
                              )
                            : ListView.builder(
                                itemCount: userAddresses.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: ListTile(
                                        title: Text(
                                            '${userAddresses[i].fullname}',
                                            style: TextStyle(fontSize: 16)),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_city,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                    '  ${userAddresses[i].cityName}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                    '  ${userAddresses[i].mobile}'),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.grey,
                                                ),
                                                Text(
                                                  '  ${userAddresses[i].address}',
                                                  overflow: TextOverflow.fade,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (dialogContext) =>
                                                  AlertDialog(
                                                title: Text('Address Delete'),
                                                content: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      5.6,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          'Are you sure, You want to delete address?'),
                                                      SizedBox(height: 14),
                                                      Text(
                                                        'If you delete this address, the orders sent to this address using "${userAddresses[i].mobile}" won\'t apear in search orders',
                                                        style: TextStyle(
                                                          fontSize: 13,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop();
                                                    },
                                                    child: Text('No'),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      userPvd.delUserAddress(
                                                          context,
                                                          userAddresses[i].id,
                                                          authPvd.user);
                                                      Navigator.of(
                                                              dialogContext)
                                                          .pop();
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                                elevation: 20,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Theme.of(context).errorColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      }
                      return LoadingIndicator();
                    },
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Stack(
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
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: senderName,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: senderCitiesDropdown,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: senderDistrict,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: senderAddress,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 23.0),
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    child: countriesCodeField,
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.2,
                                    child: senderMobileNo,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        Navigator.of(context).pop();

                                        _formKey.currentState.save();
                                        userPvd.addSenderAddress(
                                            context, _address, authPvd.user);
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
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _customDropDownExample(
      BuildContext context, SearchCityModel item, String itemDesignation) {
    Locale myLocale = Localizations.localeOf(context);

    print(myLocale.languageCode);
    return Container(
      // padding: EdgeInsets.all(0),
      height: 28,
      child: (item?.name == null)
          ? Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text('Select City'),
            )
          : ((myLocale.languageCode == 'en')
              ? Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(item.name),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(item.cityArabicName),
                )),
    );
  }

  Widget _customPopupItemBuilderExample(
      BuildContext context, SearchCityModel item, bool isSelected) {
    Locale myLocale = Localizations.localeOf(context);

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
        title: (myLocale.languageCode == 'en')
            ? Text(item.name)
            : Text(item.cityArabicName),
      ),
    );
  }
}
