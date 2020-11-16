import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/home_screen.dart';
import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account.dart';
import 'package:hani_almutairi_logistic/screens/user_order_screen.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 2;
  String _title = 'Home';

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
            _title = 'Home';
          }
          break;
        case 2:
          {
            _title = 'My Order';
          }
          break;
      }
    });
  }

  final List<Widget> _children = [
    UserAccount(),
    HomeScreen(),
    UserOrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
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
              Icons.arrow_upward,
              size: 24.0,
            ),
            title: Text(''),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     _currentIndex == 2 ? Icons.payment : Icons.payment_outlined,
          //     size: 24.0,
          //   ),
          //   title: Text('My Account'),
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2 ? Icons.payments : Icons.payments_outlined,
              size: 24.0,
            ),
            title: Text('My Orders'),
          ),
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        backgroundColor:
            _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.white,
        child: Icon(
          Icons.home,
          color: _currentIndex == 1
              ? Colors.white
              : Theme.of(context).primaryColor,
        ),
        onPressed: () {
          onTabTapped(1);
        },
      ),
    );
  }
}
