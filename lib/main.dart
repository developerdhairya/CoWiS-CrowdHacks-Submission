// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(const COWIS());
}

class COWIS extends StatelessWidget {
  const COWIS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {},
      initialRoute:'',
      theme: ThemeData(
        accentColor: Color.fromRGBO(34, 126, 34, 1),
        primaryColor:Color.fromRGBO(99, 162, 17, 1),
        primarySwatch: MaterialColor(0xFF749B2B, {
          500: Color.fromRGBO(99, 162, 17, 1),
        }),
      ),
    );
  }
}
