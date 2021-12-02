import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/pages/profile/components/page_divider.dart';
import 'package:trabalho_t3_t4/pages/profile/components/profile_image.dart';
import 'package:trabalho_t3_t4/pages/profile/components/profile_text_button.dart';
import 'package:trabalho_t3_t4/pages/profile/profile_sub_pages/change_email_page.dart';
import 'package:trabalho_t3_t4/pages/profile/profile_sub_pages/change_password_page.dart';
import 'package:trabalho_t3_t4/pages/profile/profile_sub_pages/change_username_page.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding:
          EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: size.height * 0.06),
            Row(
              children: [
                const ProfileImage(),
                Container(width: size.height * 0.025),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nome Sobrenome",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Container(height: size.height * 0.01),
                    const Text(
                      "nomedoemail@email.com",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
            Container(height: size.height * 0.16),
            const PageDivider(),
            ProfileTextButton(
              text: "Mudar nome de usuário",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ChangeUsernamePage();
                    },
                  ),
                );
              },
            ),
            const PageDivider(),
            ProfileTextButton(
              text: "Alterar email",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ChangeEmailPage();
                    },
                  ),
                );
              },
            ),
            const PageDivider(),
            ProfileTextButton(
              text: "Alterar senha",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ChangePasswordPage();
                    },
                  ),
                );
              },
            ),
            const PageDivider(),
            ProfileTextButton(
              text: "Configurações",
              press: () {},
            ),
            const PageDivider(),
            Container(height: size.height * 0.10),
            const Text(
              "Versão 1.3.10",
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
