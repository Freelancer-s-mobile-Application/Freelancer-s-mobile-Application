import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              localNofiController.showNofitication(
                  randomInt(), 'title', 'body', 'main');
            },
            child: const Text('Hit me')),
      ),
    );
  }

  int randomInt() {
    return Random().nextInt(100);
  }

  String randomString10char() {
    return Random().nextInt(100).toString();
  }
}
