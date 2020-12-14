import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/add_order.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

class EditOrderScreen extends StatelessWidget {
  static const String routeName = '/edit-order';

  final _formKey = new GlobalKey<FormState>();

  AddOrder _editOrder = AddOrder();

  @override
  Widget build(BuildContext context) {
    final editDetailsArg =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final orderPvd = Provider.of<OrderProvider>(context);
    final authPvd = Provider.of<AuthProvider>(context);

    final senderName = editDetailsArg['senderName'];
    final orderId = editDetailsArg['orderId'];
    // final senderCity = editDetailsArg['senderCity'];
    final senderAddress = editDetailsArg['senderAddress'];
    final senderDistrict = editDetailsArg['senderDistrict'];
    final senderContact = editDetailsArg['senderContact'];
    // RECEIVER DETAILS
    final receiverName = editDetailsArg['recieverName'];
    // final recieverCity = editDetailsArg['recieverCity'];
    final receiverAddress = editDetailsArg['recieverAddress'];
    final receiverDistrict = editDetailsArg['recieverDistrict'];
    final receiverContact = editDetailsArg['recieverContact'];

    final senderNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _editOrder.orderSenderName = value,
      keyboardType: TextInputType.name,
      initialValue: '$senderName',
      decoration: buildTextFieldInputDecoration("Sender", Icons.person),
    );

    final senderCitiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        // var dataConvertintoString = data.toString();
        // String smallString = dataConvertintoString != null
        //     ? dataConvertintoString.substring(5)
        //     : dataConvertintoString;
        _editOrder.orderSenderCity = data;
      },
      validator: (value) =>
          _editOrder.orderSenderCity == null ? 'Select city' : null,
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final senderDistrictField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _editOrder.orderSenderDistrict = value,
      keyboardType: TextInputType.streetAddress,
      initialValue: '$senderDistrict',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final senderAddressField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter address" : null,
      onSaved: (value) => _editOrder.orderSenderAddress = value,
      keyboardType: TextInputType.streetAddress,
      initialValue: '$senderAddress',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'sender_address')}",
          Icons.location_on),
    );

    final senderMobileNoField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter mobile no" : null,
      onSaved: (value) => _editOrder.orderSenderContact = value,
      keyboardType: TextInputType.number,
      initialValue: '$senderContact',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'mobile')}", Icons.phone),
    );

    final receiverNameField = TextFormField(
      validator: (value) => value.isEmpty ? "Please type fullname" : null,
      onSaved: (value) => _editOrder.orderReceiverName = value,
      keyboardType: TextInputType.name,
      initialValue: '$receiverName',
      decoration: buildTextFieldInputDecoration("Sender", Icons.person),
    );

    final receiverCitiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        _editOrder.orderReceiverCity = data;
      },
      validator: (value) =>
          _editOrder.orderReceiverCity == null ? 'Select city' : null,
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final receiverDistrictField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter district" : null,
      onSaved: (value) => _editOrder.orderReceiverDistrict = value,
      keyboardType: TextInputType.streetAddress,
      initialValue: '$receiverDistrict',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final receiverAddressField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter address" : null,
      onSaved: (value) => _editOrder.orderReceiverAddress = value,
      keyboardType: TextInputType.streetAddress,
      initialValue: '$receiverAddress',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'sender_address')}",
          Icons.location_on),
    );

    final receiverMobileNoField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter mobile no" : null,
      onSaved: (value) => _editOrder.orderReceiverContact = value,
      keyboardType: TextInputType.number,
      initialValue: '$receiverContact',
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'mobile')}", Icons.phone),
    );

    final editOrderBtn = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            orderPvd.editOrder(context, authPvd.user, orderId, _editOrder);
          }
        },
        child: Text(
          // 'Change Password',
          "EDIT NOW",
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
        title: Text("Edit Order"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 25),
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
                          const SizedBox(height: 20),
                          Text(
                            'Sender Detail',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: senderNameField,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: senderCitiesDropdown,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: senderDistrictField,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: senderAddressField,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: senderMobileNoField,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Receiver Detail',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: receiverNameField,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: receiverCitiesDropdown,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: receiverDistrictField,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: receiverAddressField,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: receiverMobileNoField,
                          ),
                          const SizedBox(height: 20),
                          orderPvd.isLoading
                              ? LoadingIndicator()
                              : editOrderBtn,
                          const SizedBox(height: 20),
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
