import 'package:flutter/material.dart';

import 'package:hani_almutairi_logistic/localization/app_localizations.dart';

String getTranslatedValue(BuildContext context, String key) {
  return AppLocalizations.of(context).getTranslatedValue(key);
}
