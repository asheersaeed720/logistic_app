import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/sign_up_screen.dart';
import 'package:hani_almutairi_logistic/screens/forgot_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/otp_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/utils/input_decoration.dart';
import 'package:hani_almutairi_logistic/utils/long_btn.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = new GlobalKey<FormState>();

//   String _email, _password;

//   @override
//   Widget build(BuildContext context) {
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

//     // PASSWORD
//     final passwordField = Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 25,
//       ),
//       child: TextFormField(
//         autofocus: false,
//         validator: (value) => value.isEmpty ? "Please type a password" : null,
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

//     var doLogin = () {
//       // if (_formKey.currentState.validate()) {
//       //   _formKey.currentState.save();
//       //   authPvd.login(context, _username, _password);
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
//                   height: 230.0,
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: <Widget>[
//                         emailField,
//                         Container(
//                           width: 250.0,
//                           height: 1.0,
//                           color: Colors.grey[400],
//                         ),
//                         passwordField,
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 212),
//                 child: longButton(context, "LOGIN", doLogin),
//               ),
//             ],
//           ),
//           forgotLabel,
//         ],
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  // static const String routeName = '/login';
  // static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = new GlobalKey<FormState>();

  String _username, _password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final phoneNoField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? "Please enter a phone number" : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("531020000", Icons.phone),
    );

    final countriesCodeField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Enter country code" : null,
      onSaved: (value) => _username = value,
      initialValue: '966',
      decoration: buildCountryCodeDropDownDecoration(),
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

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text(
            "Forgot password?",
            style: TextStyle(fontSize: 15.0),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
          },
        ),
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
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
      // if (_formKey1.currentState.validate()) {
      //   _formKey1.currentState.save();
      //   Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
      // }
      Navigator.of(context).pushNamed(OtpScreen.routeName);
    };

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Image.asset('./assets/images/logo.png'),
                    SizedBox(height: 40.0),
                    // Row(
                    //   children: [
                    //     Text('asd'),
                    //     phoneNoField,
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 5.3,
                          child: countriesCodeField,
                        ),
                        SizedBox(width: 10),
                        Container(
                          // width: 250,
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: phoneNoField,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: passwordField,
                    ),
                    SizedBox(height: 20.0),
                    longButton(context, 'LOGIN', doLogin),
                    SizedBox(height: 10.0),
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
