import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/home_screen.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account.dart';
import 'package:hani_almutairi_logistic/screens/order_screen/user_order_screen.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    final tabPvd = Provider.of<TabProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(tabPvd.tabTittle),
      ),
      body: tabPvd.childrenTab[tabPvd.currentTabScreen],
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: tabPvd.onTabTapped,
        currentIndex: tabPvd.currentTabScreen,
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 0
                  ? Icons.account_circle
                  : Icons.account_circle_outlined,
              size: 24.0,
            ),
            title: Text('My Account'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 1
                  ? Icons.notifications
                  : Icons.notifications_outlined,
              size: 24.0,
            ),
            title: Text('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 2
                  ? Icons.folder
                  : Icons.folder_open_outlined,
              size: 24.0,
            ),
            title: Text('My Orders'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 3
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
