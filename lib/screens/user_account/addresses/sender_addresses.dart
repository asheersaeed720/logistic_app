import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class SenderAddresses extends StatefulWidget {
  static const String routeName = '/sender-addresses';

  // final senderAddresses;
  // SenderAddresses({this.senderAddresses});

  @override
  _SenderAddressesState createState() => _SenderAddressesState();
}

class _SenderAddressesState extends State<SenderAddresses> {
  final _formKey = new GlobalKey<FormState>();

  Address _address = Address();

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);
    final userPvd = Provider.of<UserProvider>(context);

    final senderName = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your fullname" : null,
      keyboardType: TextInputType.name,
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
      onSaved: (value) => _address.senderDistrict = value,
      decoration: buildTextFieldInputDecoration("District", Icons.location_on),
    );

    final senderMobileNo = TextFormField(
      validator: (value) =>
          value.isEmpty ? "Please enter your mobile no" : null,
      keyboardType: TextInputType.number,
      onSaved: (value) => _address.senderMobileNo = value,
      decoration: buildTextFieldInputDecoration("Mobile no", Icons.phone),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<UserAddress>>(
              future: userPvd.getSenderAddresses(authPvd.user),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserAddress> userAddresses = snapshot.data;
                  return userAddresses.isEmpty
                      ? Center(child: Text('No Sender Addresses Found!'))
                      : ListView.builder(
                          itemCount: userAddresses.length,
                          itemBuilder: (context, i) {
                            return Card(
                              elevation: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text('${userAddresses[i].fullname}',
                                      style: TextStyle(fontSize: 16)),
                                  // subtitle: Text('${userAddresses[i].city}'),
                                  // trailing: Text('${userAddresses[i].mobile}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${userAddresses[i].city}'),
                                      Text('${userAddresses[i].mobile}'),
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      //ADD FUNCTION
                                      userPvd
                                          .delUserAddress(userAddresses[i].id, authPvd.user);
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
                  return Center(child: Text('No Sender Addresses Found!'));
                  // return snapshot.error;
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
                                    Navigator.of(context).pop();
                                    if (_formKey.currentState.validate()) {
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
