import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading(String text) {
  text.isEmpty ? 'Loading...' : text;
  Get.defaultDialog(
    title: text,
    content: const Center(child: CircularProgressIndicator()),
    barrierDismissible: false,
  );
}

dissmissLoading() => Get.back();
