import 'package:flutter/material.dart';

class CODAmountScreen extends StatelessWidget {
  static const String routeName = '/cod-amount';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COD Amount'),
      ),
      body: Center(
        child: Text('Cod Amount'),
      ),
    );
  }
}
