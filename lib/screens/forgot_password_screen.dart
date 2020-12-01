import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

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

    final emailField = TextFormField(
      validator: (value) => value.isEmpty ? "Please enter your email" : null,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _userCredential.email = value,
      decoration: buildTextFieldInputDecoration(
          "${getTranslatedValue(context, 'email')}", Icons.email),
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
            authPvd.getForgotPasswordKey(context, _userCredential);
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
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: emailField,
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
