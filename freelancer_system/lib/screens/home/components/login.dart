import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelancer_system/constants/controller.dart';

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
                  authController.signInWithGoogle();
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
}
