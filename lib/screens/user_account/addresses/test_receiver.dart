// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hani_almutairi_logistic/models/address.dart';
// import 'package:hani_almutairi_logistic/models/search_city.dart';
// import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
// import 'package:hani_almutairi_logistic/providers/user_provider.dart';
// import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
// import 'package:provider/provider.dart';

// class TestReceiverAddress extends StatefulWidget {
//   @override
//   _TestReceiverAddressState createState() => _TestReceiverAddressState();
// }

// class _TestReceiverAddressState extends State<TestReceiverAddress> {
//   final _formKey = new GlobalKey<FormState>();

//   Address _address = Address();

//   @override
//   Widget build(BuildContext context) {
//     final authPvd = Provider.of<AuthProvider>(context);
//     final userPvd = Provider.of<UserProvider>(context);

//     final receiverName = TextFormField(
//       validator: (value) => value.isEmpty ? "Please enter your fullname" : null,
//       keyboardType: TextInputType.name,
//       onSaved: (value) => _address.receiverName = value,
//       decoration: buildTextFieldInputDecoration("fullname", Icons.person),
//     );

//     final receiverCitiesDropdown = DropdownSearch<SearchCityModel>(
//       searchBoxController: TextEditingController(),
//       mode: Mode.BOTTOM_SHEET,
//       isFilteredOnline: true,
//       showClearButton: true,
//       showSearchBox: true,
//       onFind: (String filter) => authPvd.getCities(filter),
//       onChanged: (SearchCityModel val) {
//         _address.receiverCity = val;
//         print(_address.senderCity);
//       },
//       validator: (value) =>
//           _address.receiverCity == null ? 'Select city' : null,
//       dropdownBuilder: _customDropDownExample,
//       popupItemBuilder: _customPopupItemBuilderExample,
//     );

//     final receiverDistrict = TextFormField(
//       validator: (value) => value.isEmpty ? "Please enter your district" : null,
//       keyboardType: TextInputType.streetAddress,
//       onSaved: (value) => _address.receiverDistrict = value,
//       decoration: buildTextFieldInputDecoration("District", Icons.location_on),
//     );

//     final receiverMobileNo = TextFormField(
//       validator: (value) =>
//           value.isEmpty ? "Please enter your mobile no" : null,
//       keyboardType: TextInputType.number,
//       onSaved: (value) => _address.receiverMobileNo = value,
//       decoration: buildTextFieldInputDecoration("Mobile no", Icons.phone),
//     );

//     return Scaffold(
//       body: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             receiverName,
//             SizedBox(height: 10),
//             receiverCitiesDropdown,
//             SizedBox(height: 10),
//             receiverDistrict,
//             SizedBox(height: 10),
//             receiverMobileNo,
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: RaisedButton(
//                   onPressed: () {
//                     // Navigator.of(context).pop();
//                     if (_formKey.currentState.validate()) {
//                       _formKey.currentState.save();
//                       userPvd.addReceiverAddress(
//                           context, _address, authPvd.user);
//                     }
//                   },
//                   child: Text(
//                     "Add Address",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   color: Theme.of(context).primaryColor),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _customDropDownExample(
//       BuildContext context, SearchCityModel item, String itemDesignation) {
//     return Container(
//       // padding: EdgeInsets.all(0),
//       height: 28,
//       child: (item?.name == null)
//           ? Padding(
//               padding: const EdgeInsets.only(top: 6),
//               child: Text('Select City'),
//             )
//           : Padding(
//               padding: const EdgeInsets.only(top: 6),
//               child: Text(item.name),
//             ),
//     );
//   }

//   Widget _customPopupItemBuilderExample(
//       BuildContext context, SearchCityModel item, bool isSelected) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       decoration: !isSelected
//           ? null
//           : BoxDecoration(
//               border: Border.all(color: Theme.of(context).primaryColor),
//               borderRadius: BorderRadius.circular(5),
//               color: Colors.white,
//             ),
//       child: ListTile(
//         selected: isSelected,
//         title: Text(item.name),
//       ),
//     );
//   }
// }
