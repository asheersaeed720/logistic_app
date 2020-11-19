import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/home_screen.dart';
import 'package:hani_almutairi_logistic/screens/auth%20tab%20screen/auth_tab_screen.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account.dart';
import 'package:hani_almutairi_logistic/screens/user_order_screen.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  String _title = 'My Orders';

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'My Account';
          }
          break;
        case 1:
          {
            _title = 'Notifications';
          }
          break;
        case 2:
          {
            _title = 'My Orders';
          }
          break;
        case 3:
          {
            _title = 'Create Order';
          }
          break;
      }
    });
  }

  final List<Widget> _children = [
    UserAccount(),
    NotificationScreen(),
    UserOrderScreen(),
    AddOrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _children[_currentIndex],
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0
                  ? Icons.account_circle
                  : Icons.account_circle_outlined,
              size: 24.0,
            ),
            title: Text('My Account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1
                  ? Icons.notifications
                  : Icons.notifications_outlined,
              size: 24.0,
            ),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2 ? Icons.folder : Icons.folder_open_outlined,
              size: 24.0,
            ),
            title: Text('My Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 3
                  ? Icons.delivery_dining
                  : Icons.delivery_dining,
              size: 24.0,
            ),
            title: Text('Create order'),
          ),
        ],
      ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 4.0,
      //   backgroundColor:
      //       _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.white,
      //   child: Icon(
      //     Icons.home,
      //     color: _currentIndex == 1
      //         ? Colors.white
      //         : Theme.of(context).primaryColor,
      //   ),
      //   onPressed: () {
      //     onTabTapped(1);
      //   },
      // ),
    );
  }
}
