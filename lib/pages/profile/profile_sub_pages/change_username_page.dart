import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/rounded_button.dart';
import 'package:trabalho_t3_t4/pages/profile/profile_sub_pages/components/general_rounded_input_field.dart';

class ChangeUsernamePage extends StatelessWidget {
  const ChangeUsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String newUsername = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "lib/assets/logo.jpg",
                height: size.height * 0.25,
              ),
              SizedBox(height: size.height * 0.10),
              GeneralRoundedInputField(
                obscure: false,
                icon: Icons.person,
                hintText: "Digite nome de usuário",
                onChanged: (value) {
                  newUsername = value;
                },
              ),
              GeneralRoundedInputField(
                obscure: true,
                icon: Icons.lock,
                hintText: "Digite sua senha",
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: size.height * 0.15),
              RoundedButton(
                text: "ALTERAR",
                press: () async {
                  //final response = UserAPI.updateUserData(
                  //    'userId', newUsername, 'email', password);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
