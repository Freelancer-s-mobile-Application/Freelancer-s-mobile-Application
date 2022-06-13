// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancer_system/models/Form.dart';

class FormService {
  final CollectionReference _forms =
      FirebaseFirestore.instance.collection('forms');

  Future<void> addForm(Form form) {
    return _forms
        .add({
          // 'id': user.id,
          'userId': form.userId,
          'postId': form.postId,
          'status': form.status,
          'cv': form.files
        })
        .then((value) => print("Form Added"))
        .catchError((error) => print("Failed to add form: $error"));
  }
}
