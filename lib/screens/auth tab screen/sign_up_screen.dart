import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hani_almutairi_logistic/screens/auth%20tab%20screen/login_screen.dart';
import 'package:hani_almutairi_logistic/screens/otp_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/long_btn.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = new GlobalKey<FormState>();

//   String _email, _password, _firstName, _familyName;

//   @override
//   Widget build(BuildContext context) {
//     // FIRSTNAME
//     final firstNameField = Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 25,
//       ),
//       child: TextFormField(
//         autofocus: false,
//         validator: (value) => value.isEmpty ? "Please type a firstname" : null,
//         onSaved: (value) => _firstName = value,
//         keyboardType: TextInputType.emailAddress,
//         decoration: buildInputDecoration("FirstName", Icons.person),
//       ),
//     );

//     // FIRSTNAME
//     final familyNameField = Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 25,
//       ),
//       child: TextFormField(
//         autofocus: false,
//         validator: (value) =>
//             value.isEmpty ? "Please type a family name" : null,
//         onSaved: (value) => _familyName = value,
//         keyboardType: TextInputType.emailAddress,
//         decoration: buildInputDecoration("Family Name", Icons.family_restroom),
//       ),
//     );

//     // EMAIL
//     final emailField = Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 25,
//       ),
//       child: TextFormField(
//         autofocus: false,
//         validator: (value) => value.isEmpty ? "Please type a email" : null,
//         onSaved: (value) => _email = value,
//         keyboardType: TextInputType.emailAddress,
//         decoration: buildInputDecoration("Email", Icons.email),
//       ),
//     );

//     // MOBILE NUMBER
//     final mobileNumberField = Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 25,
//       ),
//       child: TextFormField(
//         autofocus: false,
//         validator: (value) =>
//             value.isEmpty ? "Please type a family name" : null,
//         onSaved: (value) => _familyName = value,
//         keyboardType: TextInputType.number,
//         decoration: buildInputDecoration("Mobile No", Icons.phone),
//       ),
//     );

//     // PASSWORD
//     final passwordField = Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 25,
//       ),
//       child: TextFormField(
//         autofocus: false,
//         validator: (value) => value.isEmpty ? "Please type a paswword" : null,
//         onSaved: (value) => _password = value,
//         decoration: buildInputDecorationPassword(
//           "Password",
//           Icons.lock,
//           Icons.visibility,
//         ),
//       ),
//     );

//     // FORGOT LABEL
//     final forgotLabel = Padding(
//       padding: EdgeInsets.only(top: 10.0),
//       child: FlatButton(
//         onPressed: () {},
//         child: Text(
//           "Forgot Password?",
//           style: TextStyle(
//             decoration: TextDecoration.underline,
//             color: Colors.white,
//             fontSize: 16.0,
//           ),
//         ),
//       ),
//     );

//     var doSignUp = () {
//       // if (_formKey.currentState.validate()) {
//       //   _formKey.currentState.save();
//       //   authPvd.signUp(context, _username, _password);
//       // }
//       Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
//     };

//     return Container(
//       padding: EdgeInsets.only(top: 23.0),
//       child: Column(
//         children: <Widget>[
//           Stack(
//             alignment: Alignment.topCenter,
//             overflow: Overflow.visible,
//             children: <Widget>[
//               Card(
//                 elevation: 2.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Container(
//                   width: 300.0,
//                   height: 500.0,
//                   child: Column(
//                     children: <Widget>[
//                       emailField,
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       firstNameField,
//                       Container(
//                         width: 250.0,
//                         height: 1.0,
//                         color: Colors.grey[400],
//                       ),
//                       familyNameField,
//                       Container(
//                         width: 250.0,
//                         height: 1,
//                         color: Colors.grey[400],
//                       ),
//                       mobileNumberField,
//                       Container(
//                         width: 250.0,
//                         height: 1,
//                         color: Colors.grey[400],
//                       ),
//                       passwordField,
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 475),
//                 child: longButton(context, "SIGNUP", doSignUp),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _name, _phone, _username, _email, _password, _confirmPassword;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final canceledField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please fill this" : null,
      onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Canceled", Icons.cancel),
    );

    final firstNameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type a name" : null,
      onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Firstname", Icons.person),
    );

    final countryField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type a country" : null,
      onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      initialValue: 'Saudi Arabia',
      decoration: buildCountriesDropDownDecoration(Icons.arrow_drop_down),
    );

    final citiesField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please type a City" : null,
      onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      initialValue: 'Riyadh',
      decoration: buildCountriesDropDownDecoration(Icons.arrow_drop_down),
    );

    final districtField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please fill this" : null,
      onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("District", Icons.location_on),
    );

    final mobileNoField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter No" : null,
      onSaved: (value) => _name = value,
      keyboardType: TextInputType.name,
      decoration: buildInputDecoration("Mobile", Icons.phone),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecorationPassword(
        "Password",
        Icons.lock,
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       _obscureText = !_obscureText;
        //     });
        //   },
        //   child: new Icon(
        //     _obscureText ? Icons.visibility : Icons.visibility_off,
        //   ),
        // ),
      ),
    );

    final confirmPasswordField = TextFormField(
      autofocus: false,
      obscureText: _obscureText,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please Enter Confirm Password';
        } else if (_password != _confirmPassword) {
          return 'Password fields dont match';
        }
        return null;
      },
      onSaved: (value) => _confirmPassword = value,
      decoration: buildInputDecorationPassword(
        "Confirm Password",
        Icons.lock,
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       _obscureText = !_obscureText;
        //     });
        //   },
        //   child: new Icon(
        //     _obscureText ? Icons.visibility : Icons.visibility_off,
        //   ),
        // ),
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
                    canceledField,
                    SizedBox(height: 16.0),
                    firstNameField,
                    SizedBox(height: 16.0),
                    countryField,
                    SizedBox(height: 16.0),
                    citiesField,
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
}
