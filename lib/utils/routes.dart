import 'package:hani_almutairi_logistic/screens/cod_amount_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/call_us_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/company_website_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/drop_list_of_cities_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/privacy_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/terms_conditions_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/track_my_shipment_screen.dart';
import 'package:hani_almutairi_logistic/screens/forgot_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/search_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/reset_password.dart';
import 'package:hani_almutairi_logistic/screens/sign_up_screen.dart';
import 'package:hani_almutairi_logistic/screens/change_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/order_success_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/bank_transfer_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/orders_reports_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_verification_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/address_tab.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/receiver_addresses.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/sender_addresses.dart';
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
  UserAccountScreen.routeName: (context) => UserAccountScreen(),
  UserVerificationScreen.routeName: (context) => UserVerificationScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
  FormOneWidget.routeName: (context) => FormOneWidget(),
  FormTwoWidget.routeName: (context) => FormTwoWidget(),
  OrderSuccess.routeName: (context) => OrderSuccess(),
  SenderAddresses.routeName: (context) => SenderAddresses(),
  ReceiverAddresses.routeName: (context) => ReceiverAddresses(),
  AddressTab.routeName: (context) => AddressTab(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  CompanyWebsiteScreen.routeName: (context) => CompanyWebsiteScreen(),
  CallUsScreen.routeName: (context) => CallUsScreen(),
  DropCitiesListScreen.routeName: (context) => DropCitiesListScreen(),
  PrivacyScreen.routeName: (context) => PrivacyScreen(),
  TermsConditionsScreen.routeName: (context) => TermsConditionsScreen(),
  TrackMyShipmentScreen.routeName: (context) => TrackMyShipmentScreen(),
  CODAmountScreen.routeName: (context) => CODAmountScreen(),
  SearchOrderScreen.routeName: (context) => SearchOrderScreen(),
  OrdersReportsScreen.routeName: (context) => OrdersReportsScreen(),
  BankTransferScreen.routeName: (context) => BankTransferScreen(),
};
