// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancer_system/models/Form.dart';

class FormService {
  final CollectionReference _forms =
      FirebaseFirestore.instance.collection('forms');

  Future<Form> find(String id) async {
    Form form = Form();
    await _forms.doc(id).get().then(
        (value) => form = Form.fromMap(value.data() as Map<String, dynamic>));
    return form;
  }

  Future<void> add(Form form) {
    return _forms
        .add(form.toMap())
        .then((value) => print("Form Added"))
        .catchError((error) => print("Failed to add form: $error"));
  }

  Future<void> delete(String id) async {
    await _forms
        .doc(id)
        .delete()
        .then((value) => print("Form deleted"))
        .catchError((error) => print("Failed to delete form: $error"));
  }

  Future<void> update(String id, Form form) async {
    await _forms
        .doc(id)
        .update(form.toMap())
        .then((value) => print("Form updated"))
        .catchError((error) => print("Failed to update form: $error"));
  }
}
