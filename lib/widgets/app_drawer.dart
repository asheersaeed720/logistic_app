import 'package:hani_almutairi_logistic/localization/localization_contant.dart';
import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';

import 'package:flutter/material.dart';

// SCREENS
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authPvd = Provider.of<AuthProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('./assets/images/header.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.track_changes_rounded),
            title: Text("${getTranslatedValue(context, 'track_my_shipment')}"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.call),
            // title: Text('Call us “Static page”'),
            title: Text("${getTranslatedValue(context, 'call_us')}"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.location_city_rounded),
            title: Text('Cities. It will be drop list or display list'),
            // title: Text("${getTranslatedValue(context, 'track_my_shipment')}"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.featured_play_list),
            // title: Text('Terms and Conditions'),
            title:
                Text("${getTranslatedValue(context, 'terms_and_Conditions')}"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.policy),
            // title: Text('Privacy'),
            title: Text("${getTranslatedValue(context, 'privacy')}"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.web_asset_outlined),
            // title: Text('Company website'),
            title: Text("${getTranslatedValue(context, 'company_Website')}"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            // title: Text("${getTranslatedValue(context, 'track_my_shipment')}"),
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
