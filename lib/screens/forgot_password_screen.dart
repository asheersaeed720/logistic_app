import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = new GlobalKey<FormState>();

  UserCredential _userCredential = UserCredential();

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);

    // final emailField = TextFormField(
    //   validator: (value) => value.isEmpty ? "Please enter your email" : null,
    //   keyboardType: TextInputType.emailAddress,
    //   onSaved: (value) => _userCredential.mobileNo = value,
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
      decoration: buildTextFieldInputDecoration("531020000", Icons.phone),
    );

    final forgotPasswordBtn = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            authPvd.forgotPassword(context, _userCredential);
          }
        },
        child: Text(
          'Submit',
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
        title: Text('Forgot Password'),
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
                            'Forgot Password',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 20),
                          // Container(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: 20.0),
                          //   child: emailField,
                          // ),
                          Container(
                            // padding:
                            //     const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 23.0),
                                  width:
                                      MediaQuery.of(context).size.width / 5.5,
                                  child: countriesCodeField,
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: mobileNoField,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          authPvd.isLoading
                              ? LoadingIndicator()
                              : forgotPasswordBtn,
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
