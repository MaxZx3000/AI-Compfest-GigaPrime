import 'package:flutter/material.dart';
import 'package:travelling_app/globals/colors.dart';
import 'package:travelling_app/globals/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(secondaryColors["white"] as int),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreenRouteName,
      routes: routes,
    );
  }
}