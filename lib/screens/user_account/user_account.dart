import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/screens/change_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/cod_amount_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/my_addresses/address_tab.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';

class UserAccount extends StatelessWidget {
  static const String routeName = '/user-account';

  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 25.0,
        ),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(AddressTab.routeName);
            },
            // splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddressTab.routeName);
                    },
                    icon: Icon(Icons.location_on),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CustomColor.gradientEnd,
                      CustomColor.gradientStart
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: CustomColor.gradientEnd,
                title: Text(
                  "${getTranslatedValue(context, 'my_account')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(CODAmountScreen.routeName);
            },
            // splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(CODAmountScreen.routeName);
                    },
                    icon: Icon(Icons.attach_money_sharp),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CustomColor.gradientEnd,
                      CustomColor.gradientStart
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: CustomColor.gradientEnd,
                title: Text(
                  // 'COD \n Amounts',
                  "${getTranslatedValue(context, 'cod_amounts')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            // splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search_sharp),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CustomColor.gradientEnd,
                      CustomColor.gradientStart
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: CustomColor.gradientEnd,
                title: Text(
                  // 'Reports for all \n orders and COD',
                  "${getTranslatedValue(context, 'reports_for')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
            },
            // splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ChangePasswordScreen.routeName);
                    },
                    icon: Icon(Icons.lock),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CustomColor.gradientEnd,
                      CustomColor.gradientStart
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: CustomColor.gradientEnd,
                title: Text(
                  // 'Password \n Change',
                  "${getTranslatedValue(context, 'change_password')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure, You want to Logout?'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () async {
                        authPvd.logOut(context);
                        Navigator.of(dialogContext).pop();
                      },
                      child: Text('Yes'),
                    ),
                  ],
                  elevation: 20,
                ),
              );
            },
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: Text('Logout'),
                          content: Text('Are you sure, You want to Logout?'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text('No'),
                            ),
                            FlatButton(
                              onPressed: () async {
                                authPvd.logOut(context);
                                Navigator.of(dialogContext).pop();
                              },
                              child: Text('Yes'),
                            ),
                          ],
                          elevation: 20,
                        ),
                      );
                    },
                    icon: Icon(Icons.exit_to_app),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      CustomColor.gradientEnd,
                      CustomColor.gradientStart
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: CustomColor.gradientEnd,
                title: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.0,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.8 / 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
        ),
      ),
    );
  }
}
