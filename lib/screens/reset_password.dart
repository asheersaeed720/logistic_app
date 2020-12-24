import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = '/reset-password';

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = new GlobalKey<FormState>();

  String oldPasswordVal;
  String passwordVal;
  String confirmPasswordVal;
  num _forgotPasswordKey;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);

    // CHANGE PASSWORD
    final newPassword = TextFormField(
      obscureText: _obscureText,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter Confirm Password';
        } else if (value.length < 6) {
          return 'Password must be atleast 6 characters';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          passwordVal = value;
        });
      },
      onChanged: (text) {
        passwordVal = text;
      },
      decoration: buildPasswordInputDecoration(
        // "New Password",
        "${getTranslatedValue(context, 'new_password')}",
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

    final confirmNewPassword = TextFormField(
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter Confirm Password';
        } else if (passwordVal != confirmPasswordVal) {
          return 'Password fields dont match';
        }
        return null;
      },
      onChanged: (text) {
        confirmPasswordVal = text;
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

    final keyTextfield = TextFormField(
      maxLength: 4,
      autofocus: false,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a phone number';
        } else if (_forgotPasswordKey < 5) {
          return 'Invalid Number';
        }
        return null;
      },
      onChanged: (text) {
        _forgotPasswordKey = num.parse(text);
      },
      keyboardType: TextInputType.number,
      onSaved: (value) => _forgotPasswordKey = num.parse(value),
      decoration: buildTextFieldInputDecoration("e.g 2546", Icons.lock_open),
    );

    final changePasswordBtn = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            authPvd.getForgotPasswordVerify(
                context, passwordVal, _forgotPasswordKey);
          }
        },
        child: Text(
          "${getTranslatedValue(context, 'change_password')}",
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
        title: Text(
          "Reset Password",
        ),
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
                            "${getTranslatedValue(context, 'reset_password')}",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: newPassword,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: confirmNewPassword,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: keyTextfield,
                          ),
                          const SizedBox(height: 20),
                          authPvd.isLoading
                              ? LoadingIndicator()
                              : changePasswordBtn,
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
}
