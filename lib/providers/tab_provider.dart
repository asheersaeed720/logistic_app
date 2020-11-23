import 'package:flutter/cupertino.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/user_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account.dart';

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
}
