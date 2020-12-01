import 'package:flutter/cupertino.dart';
import 'package:hani_almutairi_logistic/localization/localization.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/language.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/forms/form_two_widget.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/user_account.dart';

class TabProvider with ChangeNotifier {
  int _currentTabScreen = 3;
  int get currentTabScreen => _currentTabScreen;
  set currentTabScreen(int indexVal) {
    _currentTabScreen = indexVal;
    notifyListeners();
  }

  String _tabTittle = 'Add Order';
  String get tabTittle => _tabTittle;
  set tabTittle(String titleVal) {
    _tabTittle = titleVal;
    notifyListeners();
  }

  final List<Widget> childrenTab = [
    UserAccount(),
    NotificationScreen(),
    UserOrderScreen(),
    AddOrderScreen(),
  ];

  onTabTapped(int index) {
    currentTabScreen = index;
    switch (index) {
      case 0:
        {
          tabTittle = 'My Account';
        }
        break;
      case 1:
        {
          tabTittle = 'Notifications';
        }
        break;
      case 2:
        {
          tabTittle = 'My Orders';
        }
        break;
      case 3:
        {
          tabTittle = 'Add Order';
        }
        break;
    }
  }

  changeLanguage(context, Language language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'ar':
        _temp = Locale(language.languageCode, 'SA');
        break;

      default:
        _temp = Locale(language.languageCode, 'US');
    }
    MyApp.setLocale(context, _temp);
    print(language.languageCode);
  }
}
