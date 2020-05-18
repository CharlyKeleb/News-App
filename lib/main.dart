import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/utils/constants.dart';

void main() =>
  runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Constants.darkTheme,
      title: Constants.appName,
      home: HomeScreen(),
    );
  }
}
