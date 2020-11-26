import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot-password';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _email;

  @override
  Widget build(BuildContext context) {
    // EMAIL ADDRESS
    final emailField = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,
          labelText: 'Change password',
          contentPadding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            // propertyData.address = value;
          });
        },
      ),
    );

    // CHANGE PASSWORD
    final changePasswordButton = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(6.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            // propertyPvd.addProperty(
            //     context, propertyData, authPvd.token, authPvd.userId);
            // print(user);
            // propertyPvd.addProperty(context, user, propertyData);
          }
        },
        child: Text(
          'Reset Password',
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
        title: Text('Reset Password'),
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
                            'Reset Password',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 20),
                          emailField,
                          const SizedBox(height: 20),
                          changePasswordButton,
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
