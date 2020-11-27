import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/screens/sign_up_screen.dart';
import 'package:hani_almutairi_logistic/screens/forgot_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/otp_screen.dart';
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

    final countriesCodeField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Enter country code" : null,
      onSaved: (value) => _userCredential.password = value,
      initialValue: '966',
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );

    // final phoneNoField = TextFormField(
    //   inputFormatters: [
    //     new LengthLimitingTextInputFormatter(9),
    //   ],
    //   autofocus: false,
    //   validator: (value) {
    //     if (value.isEmpty) {
    //       return 'Please enter a phone number';
    //     } else if (_userCredential.mobileNo.length < 9) {
    //       return 'Invalid Number';
    //     }
    //     return null;
    //   },
    //   onChanged: (text) {
    //     _userCredential.mobileNo = text;
    //   },
    //   keyboardType: TextInputType.number,
    //   onSaved: (value) => _userCredential.mobileNo = value,
    //   decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
    // );

    final emailField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your email" : null,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _userCredential.email = value,
      decoration: buildTextFieldInputDecoration("Email", Icons.email),
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

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            "Forgot password?",
            style: TextStyle(fontSize: 15.0),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
          },
        ),
        FlatButton(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Sign up",
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

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 5.3,
                    //       child: countriesCodeField,
                    //     ),
                    //     SizedBox(width: 10),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 1.8,
                    //       child: phoneNoField,
                    //     ),
                    //   ],
                    // ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: emailField,
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: passwordField,
                    ),
                    const SizedBox(height: 20.0),
                    authPvd.isLoading
                        ? AuthIndicator()
                        : longButton(context, 'LOGIN', doLogin),
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
