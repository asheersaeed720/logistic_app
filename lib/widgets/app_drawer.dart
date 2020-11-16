import 'package:hani_almutairi_logistic/main.dart';
import 'package:hani_almutairi_logistic/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hani_almutairi_logistic/utils/colors.dart' as Theme;

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
          UserAccountsDrawerHeader(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                'https://www.worldfuturecouncil.org/wp-content/uploads/2020/02/dummy-profile-pic-300x300-1.png',
              ),
            ),
            accountName: Text('Username'),
            accountEmail: Text('Email'),
            // accountName: Text('${authPvd.user['user'][0]['username']}'),
            // accountEmail: Text('${authPvd.user['user'][0]['email']}'),
          ),
          ListTile(
            leading: Icon(Icons.track_changes_rounded),
            title: Text('Track my shipment'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.call),
            title: Text('Call us “Static page”'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.location_city_rounded),
            title: Text('Cities. It will be drop list or display list'),
            onTap: () {
              Navigator.pop(context);
              authPvd.logOut(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.featured_play_list),
            title: Text('Terms and Conditions'),
            onTap: () {
              Navigator.pop(context);
              authPvd.logOut(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text('Privacy'),
            onTap: () {
              Navigator.pop(context);
              authPvd.logOut(context);
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.web_asset_outlined),
            title: Text('Company website'),
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
