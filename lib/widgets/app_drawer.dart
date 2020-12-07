import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/call_us_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/company_website_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/drop_list_of_cities_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/privacy_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/terms_conditions_screen.dart';
import 'package:hani_almutairi_logistic/screens/drawer_screens/track_my_shipment_screen.dart';
import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';

import 'package:flutter/material.dart';

// SCREENS
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Consumer<AuthProvider>(
            builder: (_, authProvider, __) {
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('./assets/images/header.jpg'),
                )),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage('./assets/images/dummy_profile.png'),
                ),
                accountName: Text(
                    '${authProvider.user['user']['first_name']} ${authProvider.user['user']['last_name']}'),
                accountEmail:
                    Text('${authProvider.user['user']['user_mobile']}'),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.track_changes_rounded),
            title: Text("${getTranslatedValue(context, 'track_my_shipment')}"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(TrackMyShipmentScreen.routeName);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.call),
            title: Text("${getTranslatedValue(context, 'call_us')}"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(CallUsScreen.routeName);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.location_city_rounded),
            title: Text('Cities. It will be drop list or display list'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(DropCitiesListScreen.routeName);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.featured_play_list),
            title:
                Text("${getTranslatedValue(context, 'terms_and_Conditions')}"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(TermsConditionsScreen.routeName);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text("${getTranslatedValue(context, 'privacy')}"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(PrivacyScreen.routeName);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.web_asset_outlined),
            title: Text("${getTranslatedValue(context, 'company_Website')}"),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(CompanyWebsiteScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              authPvd.logOut(context);
            },
          ),
        ],
      ),
    );
  }
}
