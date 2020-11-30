import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';

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
    final emailField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your email" : null,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _userCredential.email = value,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'email')}", Icons.email),
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
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: emailField,
                          ),
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
