import 'package:hani_almutairi_logistic/screens/forgot_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/sign_up_screen.dart';
import 'package:hani_almutairi_logistic/screens/change_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/order_success_screen.dart';
import 'package:hani_almutairi_logistic/screens/otp_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/my_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/receiver_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/sender_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/user_account.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_one_widget.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_two_widget.dart';

final routes = {
  // LoginScreen.routeName: (context) => LoginScreen(),
  TabsScreen.routeName: (context) => TabsScreen(),
  UserOrderScreen.routeName: (context) => UserOrderScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  UserAccount.routeName: (context) => UserAccount(),
  OtpScreen.routeName: (context) => OtpScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  FormOneWidget.routeName: (context) => FormOneWidget(),
  FormTwoWidget.routeName: (context) => FormTwoWidget(),
  OrderSuccess.routeName: (context) => OrderSuccess(),
  SenderAddresses.routeName: (context) => SenderAddresses(),
  ReceiverAddresses.routeName: (context) => ReceiverAddresses(),
  MyAddresses.routeName: (context) => MyAddresses(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
};
