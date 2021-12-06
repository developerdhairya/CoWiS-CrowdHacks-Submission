// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cowis/debug_files/debug_screen.dart';
import 'package:cowis/pages/accordion_page.dart';
import 'package:cowis/pages/authentication_page.dart';
import 'package:cowis/pages/navigation_page.dart';
import 'package:cowis/pages/offerings_page.dart';
import 'package:cowis/pages/organisation_list_page.dart';
import 'package:cowis/pages/service_page.dart';
import 'package:cowis/services/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(const COWIS());
}

class COWIS extends StatelessWidget {
  const COWIS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
      routes: {
        '/authPage': (context) => AuthPage(),
        '/organisationListPage':(context)=>OrganisationListPage(),
      },
      home: NavigationPage(),
      theme: ThemeData(
          accentColor: Color.fromRGBO(34, 126, 34, 1),
          primaryColor: Color.fromRGBO(34, 126, 34, 1),
          colorScheme: ColorScheme(
            primary: Color.fromRGBO(99, 162, 17, 1),
            primaryVariant: Color.fromRGBO(99, 162, 17, 1),
            secondary: Color.fromRGBO(99, 162, 17, 1),
            secondaryVariant: Color.fromRGBO(99, 162, 17, 1),
            surface: Color.fromRGBO(99, 162, 17, 1),
            background: Color.fromRGBO(99, 162, 17, 1),
            error: Color.fromRGBO(99, 162, 17, 1),
            onPrimary: Colors.white,
            onSecondary: Color.fromRGBO(99, 162, 17, 1),
            onSurface: Color.fromRGBO(99, 162, 17, 1),
            onBackground: Color.fromRGBO(99, 162, 17, 1),
            onError: Color.fromRGBO(99, 162, 17, 1),
            brightness: Brightness.light,
          )),
    );
  }
}
