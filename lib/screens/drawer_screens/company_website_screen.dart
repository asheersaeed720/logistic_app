import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class CompanyWebsiteScreen extends StatelessWidget {
  static const String routeName = '/company-website';

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      const url = 'https://hubexsa.com';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Company Website'),
      ),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Company Website',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 10),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: _launchURL,
              child: Container(
                width: MediaQuery.of(context).size.width / 4.5,
                child: Row(
                  children: [
                    Text(
                      'Visit Here',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
