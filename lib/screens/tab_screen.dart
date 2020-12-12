import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/providers/app_language_provider.dart';

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
    );
  }
}
