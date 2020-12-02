import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localizations.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/language.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/user_account.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs';

  // final activeTabIndex;

  // TabsScreen({Key key, this.activeTabIndex}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // String _tabTittle;

  // final List<Widget> childrenTab = [
  //   UserAccount(),
  //   NotificationScreen(),
  //   UserOrderScreen(),
  //   AddOrderScreen(),
  // ];

  // int _currentTabScreen = 3;
  // onTabTapped(int index) {
  //   setState(() {
  //     _currentTabScreen = index;
  //   });

  //   switch (index) {
  //     case 0:
  //       {
  //         _tabTittle = getTranslatedValue(context, 'my_account');
  //       }
  //       break;
  //     case 1:
  //       {
  //         _tabTittle = getTranslatedValue(context, 'notifications');
  //       }
  //       break;
  //     case 2:
  //       {
  //         _tabTittle = getTranslatedValue(context, 'my_orders');
  //       }
  //       break;
  //     case 3:
  //       {
  //         _tabTittle = getTranslatedValue(context, 'add_order');
  //       }
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final tabPvd = Provider.of<TabProvider>(context);
    // final tabArg =
    //     ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    // _tabTittle = getTranslatedValue(context, 'add_order');

    return Scaffold(
      appBar: AppBar(
        // title: Text(_tabTittle ?? getTranslatedValue(context, 'add_order')),
        title: Text(tabPvd.tabTittle),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton(
              onChanged: (Language language) {
                tabPvd.changeLanguage(context, language);
              },
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (lang) => DropdownMenuItem(
                      value: lang,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${lang.flag}'),
                            Text('${lang.name}'),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
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
            title: Text(getTranslatedValue(context, 'my_account')),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 1
                  ? Icons.notifications
                  : Icons.notifications_outlined,
              size: 24.0,
            ),
            title: Text(getTranslatedValue(context, 'notifications')),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 2
                  ? Icons.folder
                  : Icons.folder_open_outlined,
              size: 24.0,
            ),
            title: Text(getTranslatedValue(context, 'my_orders')),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 3
                  ? Icons.delivery_dining
                  : Icons.delivery_dining,
              size: 24.0,
            ),
            // title: Text('Create Orders'),
            title: Text(getTranslatedValue(context, 'add_order')),
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
