import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 80,
                  child: Image.asset(
                    'assets/images/github.png',
                    width: 300,
                  )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(70.0),
                child: Image.asset('assets/images/computer_icon.png'),
              )),
              const Text(
                'Let\'s build from here ...',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Our platform drives innovation with tools that boost developer velocity',
                style: TextStyle(
                    color: Color.fromARGB(255, 137, 134, 134),
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: InkWell(
                  onTap: () => authController.signInWithGitHub(context),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xff706cff),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: const Center(
                        child: Text(
                      'Sign in with Github',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
