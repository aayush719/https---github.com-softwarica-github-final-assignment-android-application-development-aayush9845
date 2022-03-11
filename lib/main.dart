import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/Product/adminList.dart';
import 'package:shop_app/screens/Product/productForm.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/khalti/khaltiPage.dart';
import 'package:shop_app/screens/sign_in/components/sign_form.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_eca417780b9247d5ac4e791af7947fe0",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme(),
            // home: SplashScreen(),
            // We use routeName so that we dont need to remember the name

            initialRoute: SplashScreen.routeName,

            routes: routes,
          );
        });
  }
}
