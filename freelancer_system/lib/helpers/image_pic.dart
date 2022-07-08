import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String> selectRoomImage() async {
  final result = await ImagePicker().pickImage(
    imageQuality: 70,
    maxWidth: 1440,
    source: ImageSource.gallery,
  );
  String url = '';
  if (result != null) {
    final file = File(result.path);
    final size = file.lengthSync();
    final bytes = await result.readAsBytes();
    final image = await decodeImageFromList(bytes);
    final name = result.name;

    try {
      final reference = FirebaseStorage.instance.ref(name);
      await reference.putFile(file);
      url = await reference.getDownloadURL();
    } catch (e) {}
  }
  return url;
}
