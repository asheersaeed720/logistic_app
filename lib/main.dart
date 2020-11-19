import 'package:hani_almutairi_logistic/providers/auth_provider.dart';
import 'package:hani_almutairi_logistic/providers/order_provider.dart';
import 'package:hani_almutairi_logistic/screens/auth%20tab%20screen/auth_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hani_almutairi_logistic/screens/auth%20tab%20screen/login_screen.dart';
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

class MyApp extends StatelessWidget {
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
      ],
      child: MaterialApp(
        title: 'Hani Almutairi Logistic',
        debugShowCheckedModeBanner: false,
        theme: customTheme,
        // home: Consumer<AuthProvider>(
        //   builder: (_, authProvider, __) {
        //     return FutureBuilder(
        //       future: authProvider.checkLoginStatus(),
        //       builder: (context, snapshot) {
        //         return snapshot.hasData ? HomeScreen() : LoginScreen();
        //       },
        //     );
        //   },
        // ),
        home: LoginScreen(),
        // initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
