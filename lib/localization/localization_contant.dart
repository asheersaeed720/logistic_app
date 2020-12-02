import 'package:flutter/cupertino.dart';
import 'package:hani_almutairi_logistic/localization/localizations.dart';

String getTranslatedValue(BuildContext context, String key) {
  return AppLocalizations.of(context).getTranslatedValue(key);
}
