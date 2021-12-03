import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/my_drawer.dart';
import 'package:trabalho_t3_t4/pages/signup/body.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: const Body(),
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
          child: Image.asset(
            "lib/assets/logo.jpg",
            width: 38,
            height: 38,
          ),
        ),
        backgroundColor: const Color(0xFF373C44),
      ),
    );
  }
}
