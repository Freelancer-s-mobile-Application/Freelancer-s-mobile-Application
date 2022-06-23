import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/getX_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.flutter_dash,
              color: Colors.blue,
              size: 200,
            ),
            const SizedBox(height: 50),
            const Text(
              'FreeLancer',
              style: TextStyle(fontSize: 30, color: Colors.green),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton.icon(
                onPressed: () {
                  signInWithGoogle(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                icon: const Icon(
                  FontAwesomeIcons.google,
                  color: Colors.orange,
                ),
                label: const Text('Sign up with Google'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signInWithGoogle(BuildContext context) async {
    try {
      final AppController getXController = Get.put(AppController());
      final ggSignIn = getXController.ggSignIn.value;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      final GoogleSignInAccount? googleUser = await ggSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      getXController.isUserLoggedIn.value = true;
      Get.put(FirebaseAuth.instance.currentUser as User);
      Get.back();
      Get.back();
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
