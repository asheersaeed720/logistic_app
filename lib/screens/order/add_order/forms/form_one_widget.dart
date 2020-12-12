import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/add_order.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_two_widget.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/address_tab.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/filter_btn.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:hani_almutairi_logistic/widgets/radio_btn.dart';

class FormOneWidget extends StatefulWidget {
  static const String routeName = '/add-order-form-one';

  @override
  _FormOneWidgetState createState() => _FormOneWidgetState();
}

class _FormOneWidgetState extends State<FormOneWidget> {
  final _formKey = GlobalKey<FormState>();

  AddOrder _addOrder = AddOrder();

  @override
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);
    final orderPvd = Provider.of<OrderProvider>(context);
    final userPvd = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery outside riyadh \n              50 SAR',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Delivery inside riyadh \n               35 SAR',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Note: Warning that prices not including VAT',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SENDER ADDRESS SECTION
                FutureBuilder(
                  future: userPvd.getSenderAddresses(authPvd.user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserAddress> userAddresses = snapshot.data;
                      return _buildSenderAddressSection(context, filterPvd,
                          authPvd, orderPvd, userPvd, userAddresses);
                    } else if (snapshot.hasError) {
                      return snapshot.error;
                    }
                    return LoadingIndicator();
                  },
                ),

                // TIME SECTION
                _buildTimeSection(context, filterPvd, orderPvd),

                // RECEIVER ADDRESS SECTION
                FutureBuilder(
                  future: userPvd.getReceiverAddresses(authPvd.user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<UserAddress> userAddresses = snapshot.data;
                      return _buildReceiverSection(context, filterPvd, authPvd,
                          orderPvd, userPvd, userAddresses);
                    } else if (snapshot.hasError) {
                      return snapshot.error;
                    }
                    return LoadingIndicator();
                  },
                ),

                // CASH FROM RECEIVER SECTION
                _buildCashFromReceiverSection(context),

                // EXTRA INFO SECTION
                _buildExtraInfoSection(context, orderPvd),

                // NEXT BUTTON
                FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "${getTranslatedValue(context, 'next')} >",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        Flushbar(
                          title: "Field Missing",
                          message:
                              'You missing cod or sender or receiver address fields',
                          duration: Duration(seconds: 3),
                        ).show(context);
                      } else {
                        _formKey.currentState.save();
                        Navigator.of(context).pushNamed(
                          FormTwoWidget.routeName,
                          arguments: {
                            'selectedSenderAddressId':
                                orderPvd.selectedSenderAddress,
                            'senderName': _addOrder.orderSenderName,
                            'senderCity': _addOrder.orderSenderCity,
                            'senderAddress': _addOrder.orderSenderAddress,
                            'senderDistrict': _addOrder.orderSenderDistrict,
                            'senderContact': _addOrder.orderSenderContact,

                            // RECEIVER DETAILS
                            'selectedReceiverAddressId':
                                orderPvd.selectedReceiverAddress,
                            'receiverName': _addOrder.orderReceiverName,
                            'receiverCity': _addOrder.orderReceiverCity,
                            'receiverAddress': _addOrder.orderReceiverAddress,
                            'receiverDistrict': _addOrder.orderReceiverDistrict,
                            'receiverContact': _addOrder.orderReceiverContact,

                            // EXTRA DETAILS
                            'packageCheckedValue': orderPvd.packageCheckedValue,
                            'fragileCheckedValue': orderPvd.fragileCheckedValue,
                            'selectedTime': orderPvd.selectedTime,
                            'collectionCash': _addOrder.orderCollectionCash,
                            'refNo': _addOrder.orderRefNo,
                          },
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // SENDER ADDRESS SECTION
  Widget _buildSenderAddressSection(
      context, filterPvd, authPvd, orderPvd, userPvd, userAddresses) {
    final fullNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _addOrder.orderSenderName = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'full_Name')}", Icons.person),
    );

    final citiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      validator: (value) =>
          _addOrder.orderSenderCity == null ? 'Select city' : null,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        _addOrder.orderSenderCity = data;
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final districtField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _addOrder.orderSenderDistrict = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final addressField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter address" : null,
      onSaved: (value) => _addOrder.orderSenderAddress = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'sender_address')}",
          Icons.location_on),
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

    final mobileNoField = TextFormField(
      maxLength: 9,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a phone number';
        } else if (_addOrder.orderSenderContact.length < 9) {
          return 'Invalid Number';
        }
        return null;
      },
      onChanged: (text) {
        _addOrder.orderSenderContact = '966$text';
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => _addOrder.orderSenderContact = '966$value',
      decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
    );

    return Column(
      children: [
        HeadingTitle("${getTranslatedValue(context, 'sender_address')}"),
        userAddresses.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5),
                  elevation: 0,
                  onPressed: () {
                    filterPvd.activateAddressFilterBtn2();
                    orderPvd.clearSenderSelectedRadioBtn();
                  },
                  child: Text(
                    "${getTranslatedValue(context, 'new_address')}",
                    style: TextStyle(
                      color: filterPvd.addressFilterBtn2
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  color: filterPvd.addressFilterBtn2
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            : FilterBtnForClearRadioCheck(
                "${getTranslatedValue(context, 'my_address')}",
                "${getTranslatedValue(context, 'new_address')}",
                "${getTranslatedValue(context, 'saved_address')}",
                filterPvd.addressFilterBtn1,
                filterPvd.addressFilterBtn2,
                filterPvd.addressFilterBtn3,
                filterPvd.activateAddressFilterBtn1,
                filterPvd.activateAddressFilterBtn2,
                filterPvd.activateAddressFilterBtn3,
                orderPvd.clearSenderSelectedRadioBtn,
              ),
        if (filterPvd.addressFilterBtn1 == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "${getTranslatedValue(context, 'note_your_default')}",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          )
        else if (filterPvd.addressFilterBtn2 == true)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: fullNameField,
                ),
                const SizedBox(height: 14),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: citiesDropdown,
                ),
                const SizedBox(height: 14),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: districtField,
                ),
                const SizedBox(height: 14),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: addressField,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 23.0),
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: countriesCodeField,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: mobileNoField,
                    ),
                  ],
                ),
              ],
            ),
          )
        else if (filterPvd.addressFilterBtn3 == true)
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: FutureBuilder<List<UserAddress>>(
              future: userPvd.getSenderAddresses(authPvd.user),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserAddress> userAddresses = snapshot.data;
                  return userAddresses.isEmpty
                      ? Center(
                          child: Text('No Sender Address'),
                        )
                      : ListView.builder(
                          itemCount: userAddresses.length,
                          itemBuilder: (context, i) {
                            return RadioListTile(
                              value: '${userAddresses[i].id}',
                              groupValue: orderPvd.selectedSenderAddress,
                              title: Text('${userAddresses[i].fullname}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${userAddresses[i].city}'),
                                  Text('${userAddresses[i].mobile}'),
                                ],
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (currentVal) {
                                orderPvd.setSelectedSenderAddress(currentVal);
                              },
                            );
                          },
                        );
                } else if (snapshot.hasError) {
                  return Center(
                    // child: Text('No Receiver Addresses Found!'))
                    child: snapshot.error,
                  );
                }
                return LoadingIndicator();
              },
            ),
          ),
        const SizedBox(height: 18),
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

  // TIME SECTION
  Widget _buildTimeSection(context, filterPvd, orderPvd) {
    return Column(
      children: [
        HeadingTitle("${getTranslatedValue(context, 'pickup_prefer_time')}"),
        FilterBtn(
          "${getTranslatedValue(context, 'nearest')}",
          "${getTranslatedValue(context, 'today')}",
          "${getTranslatedValue(context, 'tomorrow')}",
          filterPvd.timeFilterBtn1,
          filterPvd.timeFilterBtn2,
          filterPvd.timeFilterBtn3,
          filterPvd.activateTimeFilterBtn1,
          filterPvd.activateTimeFilterBtn2,
          filterPvd.activateTimeFilterBtn3,
        ),
        if (filterPvd.timeFilterBtn1 == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "${getTranslatedValue(context, 'note_nearest_time')}",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          )
        else if (filterPvd.timeFilterBtn2 == true)
          RadioBtn(
            "${getTranslatedValue(context, 'from_9_to_12')}",
            "${getTranslatedValue(context, 'from_12_to_3')}",
            "${getTranslatedValue(context, 'from_3_to_6')}",
            'Today',
          )
        else if (filterPvd.timeFilterBtn3 == true)
          RadioBtn(
            "${getTranslatedValue(context, 'from_9_to_12')}",
            "${getTranslatedValue(context, 'from_12_to_3')}",
            "${getTranslatedValue(context, 'from_3_to_6')}",
            'Tomorrow',
          ),
        const SizedBox(height: 18),
      ],
    );
  }

  // RECEIVER SECTION
  Widget _buildReceiverSection(
      context, filterPvd, authPvd, orderPvd, userPvd, userAddresses) {
    final fullNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type Receiver name" : null,
      onSaved: (value) => _addOrder.orderReceiverName = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'receiver_name')}", Icons.person),
    );

    final citiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      validator: (value) =>
          _addOrder.orderReceiverCity == null ? 'Select city' : null,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        _addOrder.orderReceiverCity = data;
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final districtField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _addOrder.orderReceiverDistrict = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final addressField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter address" : null,
      onSaved: (value) => _addOrder.orderReceiverAddress = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'receiver_address')}",
          Icons.location_on),
    );

    final mobileNoField = TextFormField(
      maxLength: 9,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a phone number';
        } else if (_addOrder.orderReceiverContact.length < 9) {
          return 'Invalid Number';
        }
        return null;
      },
      onChanged: (text) {
        _addOrder.orderReceiverContact = '966$text';
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => _addOrder.orderReceiverContact = '966$value',
      decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
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

    return Column(
      children: [
        HeadingTitle("${getTranslatedValue(context, 'receiver_address')}"),
        userAddresses.isEmpty
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 6.5),
                  elevation: 0,
                  onPressed: () {
                    filterPvd.activateReceiverAddressFilterBtn2();
                    orderPvd.clearReceiverSelectedRadioBtn();
                  },
                  child: Text(
                    "${getTranslatedValue(context, 'new_address')}",
                    style: TextStyle(
                      color: filterPvd.receiverAddressFilterBtn2
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  color: filterPvd.receiverAddressFilterBtn2
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            : FilterBtnForClearRadioCheck(
                "${getTranslatedValue(context, 'my_address')}",
                "${getTranslatedValue(context, 'new_address')}",
                "${getTranslatedValue(context, 'saved_address')}",
                filterPvd.receiverAddressFilterBtn1,
                filterPvd.receiverAddressFilterBtn2,
                filterPvd.receiverAddressFilterBtn3,
                filterPvd.activateReceiverAddressFilterBtn1,
                filterPvd.activateReceiverAddressFilterBtn2,
                filterPvd.activateReceiverAddressFilterBtn3,
                orderPvd.clearReceiverSelectedRadioBtn,
              ),
        if (filterPvd.receiverAddressFilterBtn1 == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              "${getTranslatedValue(context, 'note_receiver_default')}",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          )
        else if (filterPvd.receiverAddressFilterBtn2 == true)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: fullNameField,
                ),
                const SizedBox(height: 14),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: citiesDropdown,
                ),
                const SizedBox(height: 14),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: districtField,
                ),
                const SizedBox(height: 14),
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: addressField,
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 23.0),
                      width: MediaQuery.of(context).size.width / 4.6,
                      child: countriesCodeField,
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: mobileNoField,
                    ),
                  ],
                ),
              ],
            ),
          )
        else if (filterPvd.receiverAddressFilterBtn3 == true)
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: FutureBuilder<List<UserAddress>>(
              future: userPvd.getReceiverAddresses(authPvd.user),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserAddress> userAddresses = snapshot.data;
                  return userAddresses.isEmpty
                      ? Center(
                          child: Text('No Receiver Address'),
                        )
                      : ListView.builder(
                          itemCount: userAddresses.length,
                          itemBuilder: (context, i) {
                            return RadioListTile(
                              value: '${userAddresses[i].id}',
                              // groupValue: _addOrder.recieverAdId,
                              groupValue: orderPvd.selectedReceiverAddress,
                              title: Text('${userAddresses[i].fullname}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${userAddresses[i].city}'),
                                  Text('${userAddresses[i].mobile}'),
                                ],
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (currentVal) {
                                orderPvd.setSelectedReceiverAddress(currentVal);
                              },
                            );
                          },
                        );
                } else if (snapshot.hasError) {
                  return Center(
                    // child: Text('No Receiver Addresses Found!'))
                    child: snapshot.error,
                  );
                }
                return LoadingIndicator();
              },
            ),
          ),
        const SizedBox(height: 18),
      ],
    );
  }

// CASH FROM RECEIVER SECTION
  Widget _buildCashFromReceiverSection(context) {
    final cashOfDeliveryAmount = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter amount" : null,
      onSaved: (value) => _addOrder.orderCollectionCash = value,
      keyboardType: TextInputType.name,
      initialValue: '0',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'cod_amounts')}", Icons.money),
    );
    return Column(
      children: [
        HeadingTitle(
            // 'Collecting Cash from Receiver',
            "${getTranslatedValue(context, 'collecting_cash_from_receiver')}"),
        const SizedBox(height: 18),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: cashOfDeliveryAmount,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "${getTranslatedValue(context, 'note_if_this_amount')}",
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

// EXTRA INFO SECTION
  Widget _buildExtraInfoSection(context, orderPvd) {
    final referenceNo = TextFormField(
      // validator: (value) => value.isEmpty ? "Please enter ref no" : null,
      onSaved: (value) => _addOrder.orderRefNo = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, '#_reference_number')}", Icons.tag),
    );

    final packagingCheckBox = CheckboxListTile(
      title: Text(
          "${getTranslatedValue(context, 'packaging_their_items_with_us')} (5 SAR)"),
      value: orderPvd.packageCheckedValue,
      onChanged: (value) {
        orderPvd.setpackageCheckedVal(value);
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    final fragileCheckBox = CheckboxListTile(
      title: Text(
          "${getTranslatedValue(context, 'adding_a_fragile_sticker_to_their_item')}"),
      value: orderPvd.fragileCheckedValue,
      onChanged: (value) {
        orderPvd.setFragileCheckedVal(value);
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
    return Column(
      children: [
        HeadingTitle(
            "${getTranslatedValue(context, 'extra_info_not_mandatory')}"),
        const SizedBox(height: 18),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: referenceNo,
        ),
        const SizedBox(height: 10),
        packagingCheckBox,
        fragileCheckBox,
      ],
    );
  }
}
