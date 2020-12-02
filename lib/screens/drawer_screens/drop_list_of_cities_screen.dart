import 'package:flutter/material.dart';

class DropCitiesListScreen extends StatelessWidget {
  static const String routeName = '/drop-cities-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drop Cities List'),
      ),
      body: Center(
        child: Text('Drop Cities List'),
      ),
    );
  }
}
