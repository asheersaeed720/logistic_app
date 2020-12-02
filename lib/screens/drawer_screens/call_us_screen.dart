import 'package:flutter/material.dart';

class CallUsScreen extends StatelessWidget {
  static const String routeName = '/call-us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Us'),
      ),
      body: Center(
        child: Text('Call Us'),
      ),
    );
  }
}
