import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import '../screens/home_page.dart';
import '../screens/login.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId:
          'Ov23liFQv5peUnthCUSV', // Replace with your secure env variables
      clientSecret: '0e291b05bdabe7905e924e1a80b27d532e0dcfba',
      redirectUrl: 'https://github-c582d.firebaseapp.com/__/auth/handler',
    );

    final result = await gitHubSignIn.signIn(context);

    if (result.token != null) {
      final AuthCredential credential =
          GithubAuthProvider.credential(result.token!);

      try {
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          Get.snackbar('Login Success', 'Logged in as ${user.displayName}');
          Get.offAll(() => HomeScreen(token: result.token!, user: user));
        }
      } catch (e) {
        Get.snackbar('Login Failed', 'Failed to login with GitHub: $e');
      }
    } else {
      Get.snackbar('GitHub login failed', 'Please try again.');
    }
  }

  void signOut() async {
    await _auth.signOut();
    Get.offAll(LoginPage());
  }
}
