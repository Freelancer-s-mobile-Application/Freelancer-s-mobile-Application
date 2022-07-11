import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';

void onTapLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        height: Get.height * 0.6,
        width: Get.width * 0.9,
        child: const LoginScreen(),
      ),
    ),
  );
}
