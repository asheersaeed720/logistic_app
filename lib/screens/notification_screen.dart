import 'package:flutter/material.dart';
import 'package:hani_almutairi_logistic/localization/localization_contant.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "${getTranslatedValue(context, 'this_is_notification_screen')}",
        ),
      ),
    );
  }
}
