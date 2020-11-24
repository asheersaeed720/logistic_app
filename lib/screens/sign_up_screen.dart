import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/screens/otp_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/long_btn.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = new GlobalKey<FormState>();

  User _user = User();

  String _confirmPassword;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final orderPvd = Provider.of<OrderProvider>(context);

    // final canceledField = TextFormField(
    //   autofocus: false,
    //   validator: (value) => value.isEmpty ? "Please fill this" : null,
    //   onSaved: (value) => _user = value,
    //   keyboardType: TextInputType.name,
    //   decoration: buildInputDecoration("Canceled", Icons.cancel),
    // );

    final firstNameField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? "Please enter your firstname" : null,
      onSaved: (value) => _user.firstname = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Firstname", Icons.person),
    );

    final lastNameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter your lastname" : null,
      onSaved: (value) => _user.lastName = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Lastname", Icons.person),
    );

    final countryField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type a country" : null,
      onSaved: (value) => _user.country = value,
      keyboardType: TextInputType.name,
      initialValue: 'Saudi Arabia',
      decoration: buildDropDownDecoration(Icons.arrow_drop_down),
    );

    final citiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      onFind: (String filter) => orderPvd.getCities(filter),
      onChanged: (SearchCityModel data) {
        _user.city = data;
      },
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final districtField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please fill this" : null,
      onSaved: (value) => _user.district = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildInputDecoration("District", Icons.location_on),
    );

    final mobileNoField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter No" : null,
      onSaved: (value) => _user.mobileNo = num.parse(value),
      keyboardType: TextInputType.number,
      decoration: buildInputDecoration("Mobile", Icons.phone),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) {
        setState(() {
          _user.password = value;
        });
      },
      onChanged: (text) {
        _user.password = text;
      },
      decoration: buildInputDecorationPassword(
        "Password",
        Icons.lock,
        GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: new Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter Confirm Password';
        } else if (_user.password != _confirmPassword) {
          return 'Password fields dont match';
        }
        return null;
      },
      onChanged: (text) {
        _confirmPassword = text;
      },
      decoration: buildInputDecorationPassword(
        "Confirm Password",
        Icons.lock,
        GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: new Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );

    var doRegister = () {
      // if (_formKey.currentState.validate()) {
      //   _formKey.currentState.save();
      // }
      Navigator.of(context).pushNamed(OtpScreen.routeName);
    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Image.asset('./assets/images/logo.png'),
                    Text(
                      'Create an Account',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 30.0),
                    firstNameField,
                    SizedBox(height: 16.0),
                    lastNameField,
                    SizedBox(height: 16.0),
                    countryField,
                    SizedBox(height: 16.0),
                    citiesDropdown,
                    SizedBox(height: 16.0),
                    districtField,
                    SizedBox(height: 16.0),
                    mobileNoField,
                    SizedBox(height: 16.0),
                    passwordField,
                    SizedBox(height: 16.0),
                    confirmPasswordField,
                    SizedBox(height: 16.0),
                    longButton(context, 'SIGNUP', doRegister),
                  ],
                ),
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
              padding: EdgeInsets.only(top: 6),
              child: Text('Select City'),
            )
          : Padding(
              padding: EdgeInsets.only(top: 6),
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
