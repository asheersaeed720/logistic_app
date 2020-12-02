import 'package:flutter/material.dart';

class CompanyWebsiteScreen extends StatelessWidget {
  static const String routeName = '/company-website';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Website'),
      ),
      body: Center(
        child: Text('Company Website'),
      ),
    );
  }
}
