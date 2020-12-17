import 'package:dropdown_search/dropdown_search.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/add_order.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/models/user_address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/providers/user_provider.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/filter_btn.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:hani_almutairi_logistic/widgets/radio_btn.dart';
import 'package:provider/provider.dart';

class OrderFormWizard extends StatefulWidget {
  static const String routeName = '/order-form-wizard';

  @override
  _OrderFormWizardState createState() => _OrderFormWizardState();
}

class _OrderFormWizardState extends State<OrderFormWizard> {
  final _formKey = GlobalKey<FormState>();

  AddOrder _addOrder = AddOrder();

  List<UserAddress> senderAddresses;

  List<UserAddress> receiverAddresses;

  @override
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);
    final orderPvd = Provider.of<OrderProvider>(context);
    final userPvd = Provider.of<UserProvider>(context);

    switch (orderPvd.stepOrderFormNumber) {
      case 1:
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Order'),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 19,
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Form(
                key: _formKey,
                child: this._buildFormOne(
                    context, filterPvd, authPvd, orderPvd, userPvd),
              ),
            ),
          ),
        );
        break;

      case 2:
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Order'),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(
                  Icons.cancel,
                  color: Colors.white,
                  size: 19,
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(TabsScreen.routeName);
                orderPvd.stepOrderFormNumber = 1;
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Form(
                key: _formKey,
                child: this._buildFormTwo(context, authPvd, orderPvd, userPvd),
              ),
            ),
          ),
        );
        break;
    }
  }

  Column _buildFormOne(context, filterPvd, authPvd, orderPvd, userPvd) {
    final senderFullNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _addOrder.orderSenderName = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'full_Name')}", Icons.person),
    );

    final senderCitiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      validator: (value) =>
          _addOrder.orderSenderCity == null ? 'Select city' : null,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        var dataString = data.toString();
        _addOrder.orderSenderCity = dataString.replaceAll(RegExp(r'[0-9]'), '');
        print(_addOrder.orderSenderCity);
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final senderDistrictField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _addOrder.orderSenderDistrict = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final senderAddressField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter address" : null,
      onSaved: (value) => _addOrder.orderSenderAddress = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'sender_address')}",
          Icons.location_on),
    );

    final senderCountriesCodeField = TextFormField(
      initialValue: '966',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '966',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    final senderMobileNoField = TextFormField(
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

    final saveSenderAddressCheckBox = CheckboxListTile(
      title: Text("Save Address for future use"),
      value: orderPvd.isSenderAddressSave,
      onChanged: (value) {
        orderPvd.setSenderAddressChecked(value);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );

    // RECEIVER FIELDS
    final receiverFullNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _addOrder.orderReceiverName = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'full_Name')}", Icons.person),
    );

    final receiverCitiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      validator: (value) =>
          _addOrder.orderReceiverCity == null ? 'Select city' : null,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        var dataString = data.toString();
        _addOrder.orderReceiverCity =
            dataString.replaceAll(RegExp(r'[0-9]'), '');
        print(_addOrder.orderReceiverCity);
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final receiverDistrictField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _addOrder.orderReceiverDistrict = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final receiverAddressField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter address" : null,
      onSaved: (value) => _addOrder.orderReceiverAddress = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'sender_address')}",
          Icons.location_on),
    );

    final receiverCountriesCodeField = TextFormField(
      initialValue: '966',
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '966',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    final receiverMobileNoField = TextFormField(
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

    final saveReceiverAddressCheckBox = CheckboxListTile(
      title: Text("Save Address for future use"),
      value: orderPvd.isReceiverAddressSave,
      onChanged: (value) {
        orderPvd.setReceiverAddressChecked(value);
      },
      controlAffinity: ListTileControlAffinity.leading,
    );

    // EXTRA

    final cashOfDeliveryAmount = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter amount" : null,
      onSaved: (value) => _addOrder.orderCollectionCash = value,
      keyboardType: TextInputType.name,
      initialValue: '0',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'cod_amounts')}", Icons.money),
    );

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
        // SENDER ADDRESS SECTION
        Column(
          children: [
            HeadingTitle("${getTranslatedValue(context, 'sender_address')}"),
            SenderAddressFilterBtn(
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
              FutureBuilder(
                future: userPvd.getSenderAddresses(authPvd.user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    senderAddresses = snapshot.data;
                    if (senderAddresses.isNotEmpty) {
                      return ListTile(
                        leading: Icon(
                          Icons.check_box_rounded,
                          color: Colors.green,
                        ),
                        title: Text('${senderAddresses.last.fullname}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${senderAddresses.last.cityName}'),
                            Text('${senderAddresses.last.mobile}'),
                          ],
                        ),
                      );
                    } else {
                      orderPvd.senderDefaultAddressNotFound =
                          'Your Default Address not found';
                      return Text('${orderPvd.senderDefaultAddressNotFound}');
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return LoadingIndicator();
                },
              )
            else if (filterPvd.addressFilterBtn2 == true)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: senderFullNameField,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: senderCitiesDropdown,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: senderDistrictField,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: senderAddressField,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 23.0),
                          width: MediaQuery.of(context).size.width / 4.6,
                          child: senderCountriesCodeField,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: senderMobileNoField,
                        ),
                      ],
                    ),
                    // const SizedBox(height: 14),
                    saveSenderAddressCheckBox,
                  ],
                ),
              )
            else if (filterPvd.addressFilterBtn3 == true)
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: FutureBuilder(
                  future: userPvd.getSenderAddresses(authPvd.user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      senderAddresses = snapshot.data;
                      if (senderAddresses.isNotEmpty) {
                        return ListView.builder(
                          itemCount: senderAddresses.length,
                          itemBuilder: (context, i) {
                            return RadioListTile(
                              value: '${senderAddresses[i].id}',
                              groupValue: orderPvd.selectedReceiverAddress,
                              title: Text('${senderAddresses[i].fullname}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${senderAddresses[i].cityName}'),
                                  Text('${senderAddresses[i].mobile}'),
                                  Text('${senderAddresses[i].address}'),
                                ],
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (currentVal) {
                                orderPvd.setSelectedReceiverAddress(currentVal);
                              },
                            );
                          },
                        );
                      } else {
                        orderPvd.senderDefaultAddressNotFound =
                            'Your Default Address not found';
                        return Text('${orderPvd.senderDefaultAddressNotFound}');
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                    return LoadingIndicator();
                  },
                ),
              ),
            const SizedBox(height: 18),
          ],
        ),

        // TIME SECTION
        Column(
          children: [
            HeadingTitle(
                "${getTranslatedValue(context, 'pickup_prefer_time')}"),
            PickupTimeFilterBtn(
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
        ),

        // RECEIVER ADDRESS SECTION

        Column(
          children: [
            HeadingTitle("${getTranslatedValue(context, 'receiver_address')}"),
            ReceiverAddressFilterBtn(
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
              orderPvd.resetReceiverDefaultAddressNotFound,
            ),
            if (filterPvd.receiverAddressFilterBtn1 == true)
              FutureBuilder(
                future: userPvd.getReceiverAddresses(authPvd.user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    senderAddresses = snapshot.data;
                    if (senderAddresses.isNotEmpty) {
                      orderPvd.receiverDefaultAddressNotFound = '';
                      return ListTile(
                        leading: Icon(
                          Icons.check_box_rounded,
                          color: Colors.green,
                        ),
                        title: Text('${receiverAddresses.last.fullname}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${receiverAddresses.last.cityName}'),
                            Text('${receiverAddresses.last.mobile}'),
                          ],
                        ),
                      );
                    } else {
                      orderPvd.receiverDefaultAddressNotFound =
                          'Receiver Default Address not found';
                      return Text('${orderPvd.receiverDefaultAddressNotFound}');
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  return LoadingIndicator();
                },
              )
            else if (filterPvd.receiverAddressFilterBtn2 == true)
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: receiverFullNameField,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: receiverCitiesDropdown,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: receiverDistrictField,
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: receiverAddressField,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 23.0),
                          width: MediaQuery.of(context).size.width / 4.6,
                          child: receiverCountriesCodeField,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: receiverMobileNoField,
                        ),
                      ],
                    ),
                    saveReceiverAddressCheckBox,
                  ],
                ),
              )
            else if (filterPvd.receiverAddressFilterBtn3 == true)
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: FutureBuilder(
                  future: userPvd.getReceiverAddresses(authPvd.user),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      receiverAddresses = snapshot.data;
                      if (receiverAddresses.isNotEmpty) {
                        return ListView.builder(
                          itemCount: receiverAddresses.length,
                          itemBuilder: (context, i) {
                            return RadioListTile(
                              value: '${receiverAddresses[i].id}',
                              groupValue: orderPvd.selectedReceiverAddress,
                              title: Text('${receiverAddresses[i].fullname}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${receiverAddresses[i].cityName}'),
                                  Text('${receiverAddresses[i].mobile}'),
                                  Text('${receiverAddresses[i].address}'),
                                ],
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (currentVal) {
                                orderPvd.setSelectedReceiverAddress(currentVal);
                              },
                            );
                          },
                        );
                      } else {
                        orderPvd.receiverDefaultAddressNotFound =
                            'Receiver Default Address not found';
                        return Text(
                            '${orderPvd.receiverDefaultAddressNotFound}');
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                    return LoadingIndicator();
                  },
                ),
              ),
            const SizedBox(height: 18),
          ],
        ),

        // CASH FROM RECEIVER SECTION
        Column(
          children: [
            HeadingTitle(
                "${getTranslatedValue(context, 'collecting_cash_from_receiver')}"),
            const SizedBox(height: 18),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: cashOfDeliveryAmount,
            ),
            const SizedBox(height: 18),
          ],
        ),

        // EXTRA INFO SECTION
        Column(
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
        ),

        // NEXT BUTTON
        RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "${getTranslatedValue(context, 'next')} >",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (!_formKey.currentState.validate()) {
              print('${_addOrder.orderReceiverCity}');
              Flushbar(
                title: 'Missing Fields',
                message: 'You missing some above fields',
                duration: Duration(seconds: 3),
              ).show(context);
            } else if (orderPvd.senderDefaultAddressNotFound ==
                'Your Default Address not found') {
              Flushbar(
                title: 'Address Missing',
                message: 'Your address missing',
                duration: Duration(seconds: 3),
              ).show(context);
            } else if (orderPvd.receiverDefaultAddressNotFound ==
                'Receiver Default Address not found') {
              Flushbar(
                title: 'Address Missing',
                message: 'Receiver address missing',
                duration: Duration(seconds: 3),
              ).show(context);
            } else {
              _formKey.currentState.save();
              orderPvd.formNavigation();
            }
          },
        ),
      ],
    );
  }

  Column _buildFormTwo(context, authPvd, orderPvd, userPvd) {
    final couponCodeField = TextFormField(
      onSaved: (value) => _addOrder.coupon = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'coupon')}", Icons.tag_faces_sharp),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),

        // SENDER & RECEIVER DETAIL SECTION
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            orderPvd.selectedSenderAddress != null
                ? FutureBuilder<List<UserAddress>>(
                    future: userPvd.getUserAddressById(
                        authPvd.user, orderPvd.selectedSenderAddress),
                    builder: (context, snapshot) {
                      List<UserAddress> userAddresses = snapshot.data;
                      if (snapshot.hasData) {
                        // senderAddressbyIdCity = userAddresses[0].cityName;
                        return Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 3.8,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 6),
                            child: Column(
                              children: [
                                Text(
                                  'Sender Detail',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('${userAddresses[0].fullname}'),
                                const SizedBox(height: 6),
                                Text('${userAddresses[0].cityName}'),
                                const SizedBox(height: 6),
                                Text('${userAddresses[0].mobile}'),
                                const SizedBox(height: 6),
                                orderPvd.orderPayer == 'Sender'
                                    ? Text('60')
                                    : Text('', style: TextStyle(fontSize: 2)),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      }
                      return LoadingIndicator();
                    },
                  )
                : Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 3.8,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 6),
                      child: _addOrder.orderSenderName != null
                          ? Column(
                              children: [
                                Text(
                                  'Sender Detail',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('${_addOrder.orderSenderName}'),
                                const SizedBox(height: 6),
                                Text('${_addOrder.orderSenderCity}'),
                                const SizedBox(height: 6),
                                Text('${_addOrder.orderSenderContact}'),
                                const SizedBox(height: 6),
                                orderPvd.orderPayer == 'Sender'
                                    ? Text('35')
                                    : Text('', style: TextStyle(fontSize: 2)),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  'Sender Detail',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('${senderAddresses.last.fullname}'),
                                const SizedBox(height: 6),
                                Text('${senderAddresses.last.cityName}'),
                                const SizedBox(height: 6),
                                Text('${senderAddresses.last.mobile}'),
                                const SizedBox(height: 6),
                                orderPvd.orderPayer == 'Sender'
                                    ? Text('35')
                                    : Text('', style: TextStyle(fontSize: 2)),
                              ],
                            ),
                    ),
                  ),
            Icon(Icons.arrow_forward_rounded),
            orderPvd.selectedReceiverAddress != null
                ? FutureBuilder<List<UserAddress>>(
                    future: userPvd.getUserAddressById(
                        authPvd.user, orderPvd.selectedReceiverAddress),
                    builder: (context, snapshot) {
                      List<UserAddress> userAddresses = snapshot.data;
                      if (snapshot.hasData) {
                        // receiverAddressbyIdCity = userAddresses[0].cityName;
                        return Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 3.8,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 6),
                            child: Column(
                              children: [
                                Text(
                                  'Receiver Detail',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text('${userAddresses[0].fullname}'),
                                const SizedBox(height: 6),
                                Text('${userAddresses[0].cityName}'),
                                const SizedBox(height: 6),
                                Text('${userAddresses[0].mobile}'),
                                const SizedBox(height: 6),
                                orderPvd.orderPayer == 'Receiver'
                                    ? Text('50')
                                    : Text('', style: TextStyle(fontSize: 2)),
                                Text(
                                  'COD Amount: 1000',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      }
                      return LoadingIndicator();
                    },
                  )
                : Card(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 3.8,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6),
                        child: _addOrder.orderReceiverName != null
                            ? Column(
                                children: [
                                  Text(
                                    'Sender Detail',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${_addOrder.orderReceiverName}'),
                                  const SizedBox(height: 6),
                                  Text('${_addOrder.orderReceiverCity}'),
                                  const SizedBox(height: 6),
                                  Text('${_addOrder.orderReceiverContact}'),
                                  const SizedBox(height: 6),
                                  orderPvd.orderPayer == 'Sender'
                                      ? Text('35')
                                      : Text('', style: TextStyle(fontSize: 2)),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    'Sender Detail',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${receiverAddresses.last.fullname}'),
                                  const SizedBox(height: 6),
                                  Text('${receiverAddresses.last.cityName}'),
                                  const SizedBox(height: 6),
                                  Text('${receiverAddresses.last.mobile}'),
                                  const SizedBox(height: 6),
                                  orderPvd.orderPayer == 'Sender'
                                      ? Text('35')
                                      : Text('', style: TextStyle(fontSize: 2)),
                                ],
                              )),
                  ),
          ],
        ),
        const SizedBox(height: 18),

        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: Text(
                    'Reference no: ${_addOrder.orderRefNo}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 14),
                  child: Image.asset(
                    './assets/images/fragile_sticker.png',
                    width: 120,
                  ),
                ),
                Text(
                  '${_addOrder.orderCollectionCash} riyals will be added to your balance if the delivery is successful',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        HeadingTitle(
            "${getTranslatedValue(context, 'who_will_be_paying_the_delievery')}"),
        const SizedBox(height: 6),
        RadioListTile(
          value: "${getTranslatedValue(context, 'sender')}",
          groupValue: orderPvd.orderPayer,
          title: Text("${getTranslatedValue(context, 'sender_to_pay')}"),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setOrderPayer(currentVal);
          },
        ),
        RadioListTile(
          value: "${getTranslatedValue(context, 'receiver')}",
          groupValue: orderPvd.orderPayer,
          title: Text("${getTranslatedValue(context, 'receiver_to_pay')}"),
          activeColor: Theme.of(context).primaryColor,
          onChanged: (currentVal) {
            orderPvd.setOrderPayer(currentVal);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          child: couponCodeField,
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                // _formKey.currentState.reset();
                orderPvd.formNavigation();
              },
              child: Text(
                "${getTranslatedValue(context, 'back/edit')}",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 8.0),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  orderPvd.addOrderTest(
                    context,
                    authPvd.user,
                    _addOrder,
                    orderPvd.isSenderAddressSave,
                    orderPvd.isReceiverAddressSave,
                    orderPvd.packageCheckedValue,
                    orderPvd.fragileCheckedValue,
                    orderPvd.selectedTime,
                    orderPvd.orderPayer,
                  );
                }
              },
              child: Text(
                "${getTranslatedValue(context, 'order_now')}",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
          ],
        )
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
}
