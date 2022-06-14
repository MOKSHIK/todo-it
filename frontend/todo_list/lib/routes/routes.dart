import 'package:todo_list/views/homepage.dart';
import 'package:todo_list/views/loginscreen.dart';

const String homePage = "/homePage";
const String loginPage = "/loginPage";

final route = {
  homePage: (context) => const HomePage(),
  loginPage: (context) => LoginScreen(),
};
