import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  static const String routeName = '/privacy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy'),
      ),
      body: Center(
        child: Text('Privacy'),
      ),
    );
  }
}
