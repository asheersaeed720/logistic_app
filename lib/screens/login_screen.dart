import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/language.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/screens/forgot_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/sign_up_screen.dart';
import 'package:hani_almutairi_logistic/screens/change_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_verification_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/long_btn.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = new GlobalKey<FormState>();

  UserCredential _userCredential = UserCredential();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);
    final tabPvd = Provider.of<TabProvider>(context);

    // final emailField = TextFormField(
    //   validator: (value) => value.isEmpty ? "Please enter your email" : null,
    //   keyboardType: TextInputType.emailAddress,
    //   onSaved: (value) => _userCredential.email = value,
    //   decoration: buildTextFieldInputDecoration(
    //       "${getTranslatedValue(context, 'email')}", Icons.email),
    // );

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
        } else if (_userCredential.mobileNo.length < 9) {
          return 'Invalid Number';
        }
        return null;
      },
      onChanged: (text) {
        _userCredential.mobileNo = '966$text';
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => _userCredential.mobileNo = '966$value',
      decoration: buildTextFieldInputDecoration("e.g 531020000", Icons.phone),
    );

    final passwordField = TextFormField(
      obscureText: _obscureText,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) {
        setState(() {
          _userCredential.password = value;
        });
      },
      onChanged: (text) {
        _userCredential.password = text;
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

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            "${getTranslatedValue(context, 'forgot_password?')}",
            style: TextStyle(fontSize: 15.0),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
          },
        ),
        FlatButton(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "${getTranslatedValue(context, 'sign_up')}",
            style: TextStyle(fontSize: 15.0),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(SignupScreen.routeName);
          },
        ),
      ],
    );

    var doLogin = () {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        authPvd.login(context, _userCredential);
      }
    };

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
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
                  color: Theme.of(context).primaryColor,
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
                    Image.asset('./assets/images/logo.png'),
                    const SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 22.0),
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
                    const SizedBox(height: 6.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: passwordField,
                    ),
                    const SizedBox(height: 20.0),
                    authPvd.isLoading
                        ? AuthIndicator()
                        : longButton(context,
                            '${getTranslatedValue(context, 'login')}', doLogin),
                    const SizedBox(height: 10.0),
                    forgotLabel
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
