import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';

class NewAddressForm extends StatefulWidget {
  @override
  _NewAddressFormState createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final _formKey = new GlobalKey<FormState>();

  String _username, _password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final fullNameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter your name" : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration('Fullname', Icons.person),
    );

    final citiesField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type a City" : null,
      onSaved: (value) => _username = value,
      keyboardType: TextInputType.name,
      initialValue: 'Riyadh',
      decoration: buildCountriesDropDownDecoration(Icons.arrow_drop_down),
    );

    final districtField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type your district" : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("District", Icons.location_city),
    );

    final mobileNoField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter a mobile no" : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("Mobile", Icons.phone),
    );

    final addressCheckBox = CheckboxListTile(
      title: Text("Save address for future use"),
      value: true,
      onChanged: (newVal) {
        print(newVal);
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 30.0),
            fullNameField,
            SizedBox(height: 16.0),
            citiesField,
            SizedBox(height: 16.0),
            districtField,
            SizedBox(height: 16.0),
            mobileNoField,
            SizedBox(height: 16.0),
            addressCheckBox,
          ],
        ),
      ),
    );
  }
}
