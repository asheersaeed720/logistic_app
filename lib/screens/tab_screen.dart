import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/screens/notification_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/add_order/add_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/order/user_order/user_order_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/user_account.dart';

import 'package:provider/provider.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/models/language.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tabs';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    final tabPvd = Provider.of<TabProvider>(context);
    // final appLangPvd = Provider.of<AppLanguage>(context);

    return Scaffold(
      appBar: AppBar(
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
            title: Text(getTranslatedValue(context, 'my_account'),
                style: TextStyle(fontSize: 13)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 1
                  ? Icons.notifications
                  : Icons.notifications_outlined,
              size: 24.0,
            ),
            title: Text(getTranslatedValue(context, 'notifications'),
                style: TextStyle(fontSize: 13)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 2
                  ? Icons.folder
                  : Icons.folder_open_outlined,
              size: 24.0,
            ),
            title: Text(getTranslatedValue(context, 'my_orders'),
                style: TextStyle(fontSize: 13)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              tabPvd.currentTabScreen == 3
                  ? Icons.delivery_dining
                  : Icons.delivery_dining,
              size: 24.0,
            ),
            // title: Text('Create Orders'),
            title: Text(getTranslatedValue(context, 'add_order'),
                style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

// class TabsScreen extends StatefulWidget {
//   static const String routeName = '/tabs';

//   @override
//   _TabsScreenState createState() => _TabsScreenState();
// }

// class _TabsScreenState extends State<TabsScreen> {
//   PageController _pageController;
//   int _page = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         physics: NeverScrollableScrollPhysics(),
//         controller: _pageController,
//         onPageChanged: onPageChanged,
//         children: <Widget>[
//           UserAccountScreen(),
//           NotificationScreen(),
//           UserOrderScreen(),
//           AddOrderScreen(),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           // mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             SizedBox(width: 2),
//             IconButton(
//               icon: Icon(
//                 Icons.account_circle,
//                 size: 24.0,
//               ),
//               color: _page == 0
//                   ? Theme.of(context).primaryColor
//                   : Theme.of(context).textTheme.caption.color,
//               onPressed: () => _pageController.jumpToPage(0),
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.notifications,
//                 size: 24.0,
//               ),
//               color: _page == 1
//                   ? Theme.of(context).primaryColor
//                   : Theme.of(context).textTheme.caption.color,
//               onPressed: () => _pageController.jumpToPage(1),
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.folder,
//                 size: 24.0,
//               ),
//               color: _page == 2
//                   ? Theme.of(context).primaryColor
//                   : Theme.of(context).textTheme.caption.color,
//               onPressed: () => _pageController.jumpToPage(2),
//             ),
//             IconButton(
//               icon: Icon(
//                 Icons.delivery_dining,
//                 size: 24.0,
//               ),
//               color: _page == 3
//                   ? Theme.of(context).primaryColor
//                   : Theme.of(context).textTheme.caption.color,
//               onPressed: () => _pageController.jumpToPage(3),
//             ),
//             SizedBox(width: 2),
//           ],
//         ),
//         shape: CircularNotchedRectangle(),
//       ),
//     );
//   }

//   void navigationTapped(int page) {
//     _pageController.jumpToPage(page);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   void onPageChanged(int page) {
//     setState(() {
//       this._page = page;
//     });
//   }
// }
