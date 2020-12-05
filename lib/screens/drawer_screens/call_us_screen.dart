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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email: info@hubexsa.com', style: Theme.of(context).textTheme.headline1),
            Text('Contact number: 8001240244', style: Theme.of(context).textTheme.headline1),
          ],
        ),
      ),
    );
  }
}
