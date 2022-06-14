import 'package:flutter/material.dart';
import 'package:todo_list/services/cacheservice.dart';
import 'package:todo_list/views/homepage.dart';
import 'package:todo_list/views/loginscreen.dart';

class DeciderView extends StatelessWidget {
  DeciderView({Key? key}) : super(key: key);

  final CacheService cacheService = CacheService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cacheService.readCache(key: "jwt"),
      builder: (context, snapShot) {
        return snapShot.hasData ? const HomePage() : LoginScreen();
      },
    );
  }
}
