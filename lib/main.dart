import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_map/pages/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Simple Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: Theme.of(context).primaryTextTheme.copyWith(
              bodyText1: TextStyle(
                fontFamily: "Courier",
                fontWeight: FontWeight.bold,
              ),
              bodyText2: TextStyle(
                fontFamily: "Courier",
                color: Colors.white70,
              ),
            ),
      ),
      home: StartPage(),
    );
  }
}
