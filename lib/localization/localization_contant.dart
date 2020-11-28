import 'package:flutter/cupertino.dart';
import 'package:hani_almutairi_logistic/localization/demo_localization.dart';

String getTranslatedValue(BuildContext context, String key) {
  return DemoLocalizations.of(context).getTranslatedValue(key);
}
