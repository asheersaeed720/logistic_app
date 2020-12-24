import 'package:flutter/material.dart';

import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/language.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/user_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabProvider with ChangeNotifier {
  int _currentTabScreen = 0;
  int get currentTabScreen => _currentTabScreen;
  set currentTabScreen(int indexVal) {
    _currentTabScreen = indexVal;
    notifyListeners();
  }

  String _tabTittle = 'My Account';
  String get tabTittle => _tabTittle;
  set tabTittle(String titleVal) {
    _tabTittle = titleVal;
    notifyListeners();
  }

  final List<Widget> childrenTab = [
    UserAccountScreen(),
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
        // test = true;
        break;
      case 'ar':
        _temp = Locale(language.languageCode, 'SA');
        // test = true;
        break;

      default:
        _temp = Locale(language.languageCode, 'US');
    }
    MyApp.setLocale(context, _temp);
    print(language.languageCode);
  }
}
