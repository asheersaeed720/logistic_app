import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/widgets/app_drawer.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';

class UserAccount extends StatelessWidget {
  static const String routeName = '/user-account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.symmetric(
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
                  padding: EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {},
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
                  'My \n Addresses',
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
                  padding: EdgeInsets.only(bottom: 40),
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
                  'COD \n Amounts',
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
                  padding: EdgeInsets.only(bottom: 40),
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
                  'Reports for all \n orders and COD',
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
                  padding: EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {},
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
                  'Password \n Change',
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
                  padding: EdgeInsets.only(bottom: 40),
                  child: IconButton(
                    onPressed: () {},
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
