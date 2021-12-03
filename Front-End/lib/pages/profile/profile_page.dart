import 'package:flutter/material.dart';
import 'package:trabalho_t3_t4/components/my_drawer.dart';
import 'package:trabalho_t3_t4/pages/profile/body.dart';
import 'package:trabalho_t3_t4/pages/search_game/search_game_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SearchGamePage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}
