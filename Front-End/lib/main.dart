import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/pages/home/home_page.dart';
import 'package:trabalho_t3_t4/pages/login/login_page.dart';
import 'package:trabalho_t3_t4/pages/profile/profile_page.dart';
import 'package:trabalho_t3_t4/pages/signup/signup_page.dart';

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
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/profile': (context) => const ProfilePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          return MaterialPageRoute(builder: (context) => const HomePage());
        }
        if (settings.name == '/login') {
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }
      },
    );
  }
}
