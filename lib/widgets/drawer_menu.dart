import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/login.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.userName,
    required this.avadar,
  });
  final String userName, avadar;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(avadar)),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 176, 42, 42),
                      border: Border.all(
                        color: const Color.fromARGB(44, 173, 169, 169),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 176, 42, 42),
                          border: Border.all(
                            color: const Color.fromARGB(44, 173, 169, 169),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 60),
              DrawerMenuItem(
                name: 'Vithea',
                icon: 'assets/images/vithea.png',
                onTap: () {},
              ),
              const SizedBox(height: 30),
              DrawerMenuItem(
                name: 'Yolo works',
                icon: 'assets/images/yolo_works.png',
                onTap: () {},
              ),
              const SizedBox(height: 30),
              DrawerMenuItem(
                name: 'One gold',
                icon: 'assets/images/one_gold.png',
                onTap: () {},
              ),
              const SizedBox(height: 30),
              DrawerMenuItem(
                name: 'Zoho books',
                icon: 'assets/images/zoho_books.png',
                onTap: () {},
              ),
              const SizedBox(height: 30),
              DrawerMenuItem(
                name: 'Logout',
                icon: 'assets/images/logout.png',
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(() => LoginPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });
  final String name, icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(icon, height: 50),
          const SizedBox(width: 10),
          Text(name),
        ],
      ),
    );
  }
}
