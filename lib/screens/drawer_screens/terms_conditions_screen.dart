import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  static const String routeName = '/terms-conditions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
      ),
      body: Center(
        child: Text('Terms & Conditions'),
      ),
    );
  }
}
