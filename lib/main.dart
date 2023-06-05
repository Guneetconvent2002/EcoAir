import 'package:clean_air_tracker/UI/prev.dart';
import 'package:flutter/material.dart';

import 'UI/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Air Tracker',
      // home: HomePage(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
