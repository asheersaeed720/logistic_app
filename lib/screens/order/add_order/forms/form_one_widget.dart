import 'package:flushbar/flushbar.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/models/address.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/filter_btn.dart';
import 'package:hani_almutairi_logistic/widgets/heading_title.dart';
import 'package:hani_almutairi_logistic/widgets/radio_btn.dart';
import 'package:provider/provider.dart';
import './form_two_widget.dart';

class FormOneWidget extends StatefulWidget {
  static const String routeName = '/add-order-form-one';

  @override
  _FormOneWidgetState createState() => _FormOneWidgetState();
}

class _FormOneWidgetState extends State<FormOneWidget> {
  final _formKey = GlobalKey<FormState>();

  Address _address = Address();

  @override
  Widget build(BuildContext context) {
    final filterPvd = Provider.of<FilterProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);
    final orderPvd = Provider.of<OrderProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // SENDER ADDRESS SECTION
                _buildSenderAddressSection(
                    context, filterPvd, authPvd, orderPvd),

                // TIME SECTION
                _buildTimeSection(context, filterPvd, orderPvd),

                // RECEIVER ADDRESS SECTION
                _buildReceiverSection(context, filterPvd, authPvd, orderPvd),

                // CASH FROM RECEIVER SECTION
                _buildCashFromReceiverSection(context),

                // EXTRA INFO SECTION
                _buildExtraInfoSection(context, orderPvd),

                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Next >',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      Flushbar(
                        title: "Field Missing",
                        message:
                            'You missing sender or receiver address fields',
                        duration: Duration(seconds: 3),
                      ).show(context);
                    } else {
                      _formKey.currentState.save();
                      Navigator.of(context).pushNamed(
                        FormTwoWidget.routeName,
                        arguments: {
                          'senderName': _address.senderName,
                          'senderCity': _address.senderCity,
                          'senderDistrict': _address.senderDistrict,
                          'senderMobile': _address.senderMobileNo,
                          'receiverName': _address.receiverName,
                          'receiverCity': _address.receiverCity,
                          'receiverDistrict': _address.receiverDistrict,
                          'receiverMobile': _address.receiverMobileNo,
                        },
                      );
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
  Widget _buildSenderAddressSection(context, filterPvd, authPvd, orderPvd) {
    final fullNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _address.senderName = value,
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
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        _address.senderCity = data;
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final districtField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _address.senderDistrict = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final mobileNoField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter mobile no" : null,
      onSaved: (value) => _address.senderMobileNo = value,
      keyboardType: TextInputType.number,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'mobile')}", Icons.phone),
    );

    return Column(
      children: [
        HeadingTitle("${getTranslatedValue(context, 'sender_address')}"),
        FilterBtn(
          "${getTranslatedValue(context, 'my_address')}",
          "${getTranslatedValue(context, 'new_address')}",
          "${getTranslatedValue(context, 'saved_address')}",
          filterPvd.addressFilterBtn1,
          filterPvd.addressFilterBtn2,
          filterPvd.addressFilterBtn3,
          filterPvd.activateAddressFilterBtn1,
          filterPvd.activateAddressFilterBtn2,
          filterPvd.activateAddressFilterBtn3,
        ),
        if (filterPvd.addressFilterBtn1 == true)
          Text(
            // 'Note: Your Default address which was submitted \n when you created account.',
            "${getTranslatedValue(context, 'note_your_default')}",
            style: TextStyle(color: Theme.of(context).errorColor, fontSize: 15),
          )
        else if (filterPvd.addressFilterBtn2 == true)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                fullNameField,
                const SizedBox(height: 14),
                citiesDropdown,
                const SizedBox(height: 14),
                districtField,
                const SizedBox(height: 14),
                mobileNoField,
              ],
            ),
          )
        else if (filterPvd.addressFilterBtn3 == true)
          Column(
            children: [
              RadioListTile(
                value: 'Person name 1',
                groupValue: orderPvd.selectedAddress,
                title: Text('Shakir Afzal'),
                subtitle: Text('Al-Madina 5862135'),
                activeColor: Theme.of(context).primaryColor,
                onChanged: (currentVal) {
                  orderPvd.setSelectedAddress(currentVal);
                },
              ),
              Divider(),
              RadioListTile(
                value: 'Person name 2',
                groupValue: orderPvd.selectedAddress,
                title: Text('Jahangir'),
                subtitle: Text('Test & 5862133'),
                activeColor: Theme.of(context).primaryColor,
                onChanged: (currentVal) {
                  orderPvd.setSelectedAddress(currentVal);
                },
              ),
            ],
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
        HeadingTitle('Pickup Prefer Time'),
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
          Text(
            'Note: Nearest time',
            style: TextStyle(color: Theme.of(context).errorColor),
          )
        else if (filterPvd.timeFilterBtn2 == true)
          RadioBtn(
            "${getTranslatedValue(context, 'from_9_to_12')}",
            "${getTranslatedValue(context, 'from_12_to_3')}",
            "${getTranslatedValue(context, 'from_3_to_6')}",
          )
        else if (filterPvd.timeFilterBtn3 == true)
          RadioBtn(
            "${getTranslatedValue(context, 'from_9_to_12')}",
            "${getTranslatedValue(context, 'from_12_to_3')}",
            "${getTranslatedValue(context, 'from_3_to_6')}",
          ),
        const SizedBox(height: 18),
      ],
    );
  }

  // RECEIVER SECTION
  Widget _buildReceiverSection(context, filterPvd, authPvd, orderPvd) {
    final fullNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type Receiver name" : null,
      onSaved: (value) => _address.receiverName = value,
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
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        _address.receiverCity = data;
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final districtField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _address.receiverDistrict = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final mobileNoField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter mobile no" : null,
      onSaved: (value) => _address.receiverMobileNo = value,
      keyboardType: TextInputType.number,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'mobile')}", Icons.phone),
    );

    return Column(
      children: [
        HeadingTitle('Receiver Address'),
        FilterBtn(
          "${getTranslatedValue(context, 'my_address')}",
          "${getTranslatedValue(context, 'new_address')}",
          "${getTranslatedValue(context, 'saved_address')}",
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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Column(
              children: [
                fullNameField,
                const SizedBox(height: 14),
                citiesDropdown,
                const SizedBox(height: 14),
                districtField,
                const SizedBox(height: 14),
                mobileNoField,
              ],
            ),
          )
        else if (filterPvd.receiverAddressFilterBtn3 == true)
          Column(
            children: [
              RadioListTile(
                value: 'Person name 1',
                groupValue: orderPvd.selectedAddress,
                title: Text('Asif Khan'),
                subtitle: Text('Riyadh & 59266551'),
                activeColor: Theme.of(context).primaryColor,
                onChanged: (currentVal) {
                  orderPvd.setSelectedAddress(currentVal);
                },
              ),
              Divider(),
              RadioListTile(
                value: 'Person name 2',
                groupValue: orderPvd.selectedAddress,
                title: Text('Person name 2'),
                subtitle: Text('City Name & Number 2'),
                activeColor: Theme.of(context).primaryColor,
                onChanged: (currentVal) {
                  orderPvd.setSelectedAddress(currentVal);
                },
              ),
            ],
          ),
        const SizedBox(height: 18),
      ],
    );
  }

// CASH FROM RECEIVER SECTION
  Widget _buildCashFromReceiverSection(context) {
    final cashOfDeliveryAmount = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter amount" : null,
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      initialValue: '0',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'cod_amounts')}", Icons.money),
    );
    return Column(
      children: [
        HeadingTitle('Collecting Cash from Receiver'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          child: cashOfDeliveryAmount,
        ),
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
      // onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, '#_reference_number')}", Icons.tag),
    );

    final packagingCheckBox = CheckboxListTile(
      title: Text(
          "${getTranslatedValue(context, 'packaging_their_items_with_us')}"),
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
          child: referenceNo,
        ),
        packagingCheckBox,
        fragileCheckBox,
      ],
    );
  }
}
