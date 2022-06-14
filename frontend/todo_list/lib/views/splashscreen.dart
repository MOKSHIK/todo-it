import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/views/deciderview.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.pushReplacement(
        context,
        PageTransition(
            child: DeciderView(), type: PageTransitionType.leftToRight),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "TO",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "DO-IT",
                        style: TextStyle(
                            color: ConstantColors.accentColor,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                CircularProgressIndicator(
                  color: ConstantColors.accentColor,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
    );
  }
}
