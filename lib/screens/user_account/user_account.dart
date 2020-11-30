import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/change_password_screen.dart';
import 'package:hani_almutairi_logistic/screens/user_account/addresses/my_addresses.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:provider/provider.dart';

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
            onTap: () {},
            // splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(MyAddresses.routeName);
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
            onTap: () {},
            // splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {},
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
            onTap: () {},
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
            onTap: () {},
            // splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            child: GridTile(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {
                      authPvd.logOut(context);
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
