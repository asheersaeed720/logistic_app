// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hani_almutairi_logistic/screens/auth%20tab%20screen/login_screen.dart';
// import 'package:hani_almutairi_logistic/screens/auth%20tab%20screen/sign_up_screen.dart';
// import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
// import 'package:hani_almutairi_logistic/utils/theme.dart';
// import 'package:hani_almutairi_logistic/utils/bubble_indication_painter.dart';

// class AuthTabScreen extends StatefulWidget {
//   static const String routeName = '/';

//   AuthTabScreen({Key key}) : super(key: key);

//   @override
//   _AuthTabScreenState createState() => new _AuthTabScreenState();
// }

// class _AuthTabScreenState extends State<AuthTabScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//   final FocusNode myFocusNodeEmailLogin = FocusNode();
//   final FocusNode myFocusNodePasswordLogin = FocusNode();

//   final FocusNode myFocusNodePassword = FocusNode();
//   final FocusNode myFocusNodeEmail = FocusNode();
//   final FocusNode myFocusNodeName = FocusNode();

//   TextEditingController loginEmailController = new TextEditingController();
//   TextEditingController loginPasswordController = new TextEditingController();

//   bool _obscureTextLogin = true;
//   bool _obscureTextSignup = true;
//   bool _obscureTextSignupConfirm = true;

//   TextEditingController signupEmailController = new TextEditingController();
//   TextEditingController signupNameController = new TextEditingController();
//   TextEditingController signupPasswordController = new TextEditingController();
//   TextEditingController signupConfirmPasswordController =
//       new TextEditingController();

//   PageController _pageController;

//   Color left = Colors.black;
//   Color right = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: _scaffoldKey,
//       body: NotificationListener<OverscrollIndicatorNotification>(
//         onNotification: (overscroll) {
//           overscroll.disallowGlow();
//         },
//         child: SingleChildScrollView(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height >= 700.0
//                 ? MediaQuery.of(context).size.height
//                 : 775.0,
//             decoration: new BoxDecoration(
//               gradient: new LinearGradient(
//                 colors: [
//                   CustomColor.gradientStart,
//                   CustomColor.gradientEnd,
//                 ],
//                 begin: const FractionalOffset(0.0, 0.0),
//                 end: const FractionalOffset(1.0, 1.0),
//                 stops: [0.0, 1.0],
//                 tileMode: TileMode.clamp,
//               ),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(top: 75.0),
//                   child: new Image(
//                     width: 250.0,
//                     // height: 191.0,
//                     fit: BoxFit.cover,
//                     image: new AssetImage('assets/images/logo.png'),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 20.0),
//                   child: _buildMenuBar(context),
//                 ),
//                 Expanded(
//                   flex: 2,
//                   child: PageView(
//                     controller: _pageController,
//                     onPageChanged: (i) {
//                       if (i == 0) {
//                         setState(() {
//                           right = Colors.white;
//                           left = Colors.black;
//                         });
//                       } else if (i == 1) {
//                         setState(() {
//                           right = Colors.black;
//                           left = Colors.white;
//                         });
//                       }
//                     },
//                     children: <Widget>[
//                       new ConstrainedBox(
//                         constraints: const BoxConstraints.expand(),
//                         child: LoginScreen(),
//                       ),
//                       new ConstrainedBox(
//                         constraints: const BoxConstraints.expand(),
//                         child: SignUpScreen(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     myFocusNodePassword.dispose();
//     myFocusNodeEmail.dispose();
//     myFocusNodeName.dispose();
//     _pageController?.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     _pageController = PageController();
//   }

//   void showInSnackBar(String value) {
//     FocusScope.of(context).requestFocus(new FocusNode());
//     _scaffoldKey.currentState?.removeCurrentSnackBar();
//     _scaffoldKey.currentState.showSnackBar(new SnackBar(
//       content: new Text(
//         value,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 16.0,
//         ),
//       ),
//       backgroundColor: Colors.blue,
//       duration: Duration(seconds: 3),
//     ));
//   }

//   Widget _buildMenuBar(BuildContext context) {
//     return Container(
//       width: 300.0,
//       height: 50.0,
//       decoration: BoxDecoration(
//         color: Color(0x552B2B2B),
//         borderRadius: BorderRadius.all(Radius.circular(25.0)),
//       ),
//       child: CustomPaint(
//         painter: TabIndicationPainter(pageController: _pageController),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Expanded(
//               child: FlatButton(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onPressed: _onSignInButtonPress,
//                 child: Text(
//                   "Login",
//                   style: TextStyle(
//                     color: left,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             //Container(height: 33.0, width: 1.0, color: Colors.white),
//             Expanded(
//               child: FlatButton(
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent,
//                 onPressed: _onSignUpButtonPress,
//                 child: Text(
//                   "Register",
//                   style: TextStyle(
//                     color: right,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _onSignInButtonPress() {
//     _pageController.animateToPage(0,
//         duration: Duration(milliseconds: 500), curve: Curves.decelerate);
//   }

//   void _onSignUpButtonPress() {
//     _pageController?.animateToPage(1,
//         duration: Duration(milliseconds: 500), curve: Curves.decelerate);
//   }

//   void _toggleLogin() {
//     setState(() {
//       _obscureTextLogin = !_obscureTextLogin;
//     });
//   }

//   void _toggleSignup() {
//     setState(() {
//       _obscureTextSignup = !_obscureTextSignup;
//     });
//   }

//   void _toggleSignupConfirm() {
//     setState(() {
//       _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
//     });
//   }
// }
