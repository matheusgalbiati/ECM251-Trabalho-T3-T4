import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/alredy_have_an_account_check.dart';
import 'package:trabalho_t3_t4/components/rounded_button.dart';
import 'package:trabalho_t3_t4/components/rounded_input_field.dart';
import 'package:trabalho_t3_t4/components/rounded_password_field.dart';
import 'package:trabalho_t3_t4/pages/profile/profile_sub_pages/components/general_rounded_input_field.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String firstName = '';
    String lastName = '';
    String email = '';
    String password = '';

    return Container(
      width: double.infinity,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/logo.jpg",
              height: size.height * 0.25,
            ),
            RoundedInputField(
              hintText: "Nome",
              onChanged: (value) {
                firstName = value;
              },
            ),
            RoundedInputField(
              hintText: "Sobrenome",
              onChanged: (value) {
                lastName = value;
              },
            ),
            GeneralRoundedInputField(
              hintText: "Seu email",
              icon: Icons.mail,
              onChanged: (value) {
                email = value;
              },
              obscure: false,
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "CRIAR CONTA",
              press: () async {
                /*final response = await UserAPI.postUser(
                  firstName,
                  lastName,
                  email,
                  password,
                );*/
                Navigator.pushNamed(context, '/');
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
