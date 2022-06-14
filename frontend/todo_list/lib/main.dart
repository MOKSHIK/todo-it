// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:todo_list/views/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: route,
      home: SplashScreen(),
    );
  }
}
