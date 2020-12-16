import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/language.dart';
import 'package:hani_almutairi_logistic/models/search_city.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/long_btn.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

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
    final authPvd = Provider.of<AuthProvider>(context);
    final tabPvd = Provider.of<TabProvider>(context);

    final firstNameField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? "Please enter your firstname" : null,
      onSaved: (value) => _user.firstname = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'firstname')}", Icons.person),
    );

    final lastNameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter your lastname" : null,
      onSaved: (value) => _user.lastName = value,
      keyboardType: TextInputType.name,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'lastname')}", Icons.person),
    );

    // final emailField = TextFormField(
    //   autofocus: false,
    //   validator: (value) => value.isEmpty ? "Please enter your email" : null,
    //   onSaved: (value) => _user.email = value,
    //   keyboardType: TextInputType.name,
    //   decoration: buildTextFieldInputDecoration(
    //       "${getTranslatedValue(context, 'email')}", Icons.email),
    // );

    final countryField = TextFormField(
      autofocus: false,
      // validator: (value) => value.isEmpty ? "Please type a country" : null,
      onSaved: (value) => _user.country = value,
      keyboardType: TextInputType.name,
      // initialValue: 'Saudi Arabia',
      initialValue: "${getTranslatedValue(context, 'saudi_arabia')}",
      decoration: buildTextFieldInputDecoration("Country", Icons.map),
    );

    final citiesDropdown = DropdownSearch<SearchCityModel>(
      searchBoxController: TextEditingController(),
      mode: Mode.BOTTOM_SHEET,
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      onFind: (String filter) => authPvd.getCities(filter),
      onChanged: (SearchCityModel val) {
        _user.cityId = val;
        print(_user.cityId);
      },
      validator: (value) => _user.cityId == null ? 'Select city' : null,
      dropdownBuilder: _customDropDownExample,
      popupItemBuilder: _customPopupItemBuilderExample,
    );

    final districtField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please fill this" : null,
      onSaved: (value) => _user.district = value,
      keyboardType: TextInputType.streetAddress,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'district')}", Icons.location_on),
    );

    final addressField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please fill this" : null,
      onSaved: (value) => _user.address = value,
      keyboardType: TextInputType.streetAddress,
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

    final mobileNoField = TextFormField(
      maxLength: 9,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a phone number';
        } else if (_user.mobileNo.length < 9) {
          return 'Invalid Number';
        }
        return null;
      },
      onChanged: (text) {
        _user.mobileNo = '966$text';
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => _user.mobileNo = '966$value',
      decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter Confirm Password';
        } else if (value.length < 7) {
          return 'Password must be atleast 6 characters';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _user.password = value;
        });
      },
      onChanged: (text) {
        _user.password = text;
      },
      decoration: buildPasswordInputDecoration(
        "${getTranslatedValue(context, 'password')}",
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
      decoration: buildPasswordInputDecoration(
        "${getTranslatedValue(context, 'confirm_password')}",
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
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        authPvd.signUp(context, _user);
      }
    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${getTranslatedValue(context, 'register')}'),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton(
                onChanged: (Language language) {
                  tabPvd.changeLanguage(context, language);
                },
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (lang) => DropdownMenuItem(
                        value: lang,
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${lang.flag}'),
                              Text('${lang.name}'),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Image.asset('./assets/images/logo.png'),
                    Text(
                      'Create an Account',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: firstNameField,
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: lastNameField,
                    ),
                    // const SizedBox(height: 16.0),
                    // emailField,
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: countryField,
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: citiesDropdown,
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: districtField,
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: addressField,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 23.0),
                          width: MediaQuery.of(context).size.width / 5.3,
                          child: countriesCodeField,
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: mobileNoField,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: passwordField,
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: confirmPasswordField,
                    ),
                    const SizedBox(height: 16.0),
                    authPvd.isLoading
                        ? AuthIndicator()
                        : longButton(
                            context,
                            '${getTranslatedValue(context, 'sign_up')}',
                            doRegister),
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
