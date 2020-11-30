import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = new GlobalKey<FormState>();

  String oldPasswordVal;
  String passwordVal;
  String changePasswordVal;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // OLD PASSWORD
    final oldPassword = TextFormField(
      obscureText: _obscureText,
      validator: (value) => value.isEmpty ? "Please enter old password" : null,
      onSaved: (value) {
        setState(() {
          oldPasswordVal = value;
        });
      },
      onChanged: (text) {
        oldPasswordVal = text;
      },
      decoration: buildPasswordInputDecoration(
        "Old Password",
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

    // CHANGE PASSWORD
    final newPassword = TextFormField(
      obscureText: _obscureText,
      validator: (value) => value.isEmpty ? "Please enter new password" : null,
      onSaved: (value) {
        setState(() {
          passwordVal = value;
        });
      },
      onChanged: (text) {
        passwordVal = text;
      },
      decoration: buildPasswordInputDecoration(
        "New Password",
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
      obscureText: _obscureText,
      validator: (value) =>
          value.isEmpty ? "Please confirm your password" : null,
      onSaved: (value) {
        setState(() {
          changePasswordVal = value;
        });
      },
      onChanged: (text) {
        changePasswordVal = text;
      },
      decoration: buildPasswordInputDecoration(
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
            // propertyPvd.addProperty(
            //     context, propertyData, authPvd.token, authPvd.userId);
            // print(user);
            // propertyPvd.addProperty(context, user, propertyData);
          }
        },
        child: Text(
          'Change Password',
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
        title: Text('Change Password'),
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
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: oldPassword,
                          ),
                          const SizedBox(height: 20),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: newPassword),
                          const SizedBox(height: 20),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: confirmNewPassword,
                          ),
                          const SizedBox(height: 20),
                          changePasswordBtn,
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
