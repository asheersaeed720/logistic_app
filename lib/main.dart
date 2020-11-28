import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hani_almutairi_logistic/localization/demo_localization.dart';
import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/filter_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/providers/tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hani_almutairi_logistic/screens/login_screen.dart';
import 'package:hani_almutairi_logistic/screens/tab_screen.dart';

import 'package:hani_almutairi_logistic/utils/routes.dart';
import 'package:hani_almutairi_logistic/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findRootAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider.value(
          value: OrderProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FilterProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Hani Almutairi Logistic',
        debugShowCheckedModeBanner: false,
        locale: _locale,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'SA'),
          // Locale('fa', 'IR'),
          // Locale('hi', 'IN'),
        ],
        localizationsDelegates: [
          DemoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        theme: customTheme,
        home: Consumer<AuthProvider>(
          builder: (_, authProvider, __) {
            return FutureBuilder(
              future: authProvider.checkLoginStatus(),
              builder: (context, snapshot) {
                return snapshot.hasData ? TabsScreen() : LoginScreen();
              },
            );
          },
        ),
        routes: routes,
      ),
    );
  }
}
