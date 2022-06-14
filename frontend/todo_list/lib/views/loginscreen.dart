// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/routes/routes.dart';
import 'package:todo_list/services/authenticationservice.dart';
import 'package:todo_list/services/cacheservice.dart';
import 'package:todo_list/views/registration.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Map<String, dynamic> data = {};
  CacheService cacheService = CacheService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Image.asset('images/image2.png'),
            ),
            SizedBox(
              height: 100.0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(35.0)),
                color: ConstantColors.box,
              ),
              height: 330.0,
              width: 330.0,
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ConstantColors.accentColor,
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        data = await Authentication.login(
                            emailController.text, passwordController.text);
                        if (data['auth'] as bool) {
                          await cacheService.writeCache(
                              key: "jwt", value: data['token']);
                          await cacheService.writeCache(
                              key: "id", value: data['id']);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: ConstantColors.accentColor,
                            content: Text(data['message']),
                          ));
                          Navigator.of(context).popAndPushNamed(homePage);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: ConstantColors.accentColor,
                            content: Text(data['message']),
                          ));
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do not have an account ?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistraionScreen()),
                          );
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              color: ConstantColors.accentColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
