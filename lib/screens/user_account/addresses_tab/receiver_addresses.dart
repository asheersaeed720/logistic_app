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

class ReceiverAddresses extends StatefulWidget {
  static const String routeName = '/receiver-addresses';

  @override
  _ReceiverAddressesState createState() => _ReceiverAddressesState();
}

class _ReceiverAddressesState extends State<ReceiverAddresses> {
  final _formKey = new GlobalKey<FormState>();

  Address _address = Address();

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);
    final userPvd = Provider.of<UserProvider>(context);

    final receiverName = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your fullname" : null,
      keyboardType: TextInputType.name,
      onSaved: (value) => _address.receiverName = value,
      decoration: buildTextFieldInputDecoration("fullname", Icons.person),
    );

    final receiverCitiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel val) {
        _address.receiverCity = val;
        print(_address.receiverCity);
      },
      validator: (value) =>
          _address.receiverCity == null ? 'Select city' : null,
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final receiverDistrict = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your district" : null,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) => _address.receiverDistrict = value,
      decoration: buildTextFieldInputDecoration("District", Icons.location_on),
    );

    final receiverAddress = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your address" : null,
      keyboardType: TextInputType.streetAddress,
      onSaved: (value) => _address.receiverAddress = value,
      decoration: buildTextFieldInputDecoration("Address", Icons.location_on),
    );

    final receiverMobileNo = TextFormField(
      validator: (value) =>
          value.isEmpty ? "Please enter your mobile no" : null,
      keyboardType: TextInputType.number,
      onSaved: (value) => _address.receiverMobileNo = value,
      decoration: buildTextFieldInputDecoration("Mobile no", Icons.phone),
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder<List<UserAddress>>(
              future: userPvd.getReceiverAddresses(authPvd.user),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserAddress> userAddresses = snapshot.data;
                  return userAddresses.isEmpty
                      ? Center(child: Text('No Receiver Addresses Found!'))
                      : ListView.builder(
                          itemCount: userAddresses.length,
                          itemBuilder: (context, i) {
                            return Card(
                              elevation: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  title: Text(
                                    '${userAddresses[i].fullname}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  // subtitle: Text('${userAddresses[i].city}'),
                                  // trailing: Text('${userAddresses[i].mobile}'),
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
                                          Text('  ${userAddresses[i].mobile}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.grey,
                                          ),
                                          Text('  ${userAddresses[i].address}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      //ADD FUNCTION
                                      userPvd.delUserAddress(
                                          userAddresses[i].id, authPvd.user);
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
                  return Center(child: Text('No Receiver Addresses Found!'));
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
                              receiverName,
                              SizedBox(height: 10),
                              receiverCitiesDropdown,
                              SizedBox(height: 10),
                              receiverDistrict,
                              SizedBox(height: 10),
                              receiverAddress,
                              SizedBox(height: 10),
                              receiverMobileNo,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        userPvd.addReceiverAddress(
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
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   onPressed: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => TestReceiverAddress(),
        //       ),
        //     );
        //   },
        //   child: Icon(Icons.add),
        // ),
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
