import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyWebsiteScreen extends StatelessWidget {
  static const String routeName = '/company-website';

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      const url = 'https://hubexsa.com';
      // if (await canLaunch(url)) {
      //   await launch(url);
      // } else {
      //   // throw 'Could not launch $url';
      // }

      try {
        if (await canLaunch(url)) {
          await launch(url);
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Company Website'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _launchURL,
          child: new Text('Company Website'),
        ),
      ),
    );
  }
}
