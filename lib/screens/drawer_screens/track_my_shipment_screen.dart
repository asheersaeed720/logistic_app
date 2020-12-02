import 'package:flutter/material.dart';

class TrackMyShipmentScreen extends StatelessWidget {
  static const String routeName = '/track-my-shipment';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track My Shipment'),
      ),
      body: Center(
        child: Text('Track My Shipment'),
      ),
    );
  }
}
