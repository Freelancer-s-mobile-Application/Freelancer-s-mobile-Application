// ignore_for_file: file_names, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/models/Form.dart';
import 'package:path_provider/path_provider.dart';

class FormService {
  final CollectionReference _forms =
      FirebaseFirestore.instance.collection('Forms');

  final storageRef = FirebaseStorage.instance.ref();

  Future<ApplicationForm> find(String id) async {
    ApplicationForm form = ApplicationForm();
    await _forms.doc(id).get().then((value) =>
        form = ApplicationForm.fromMap(value.data() as Map<String, dynamic>));
    return form;
  }

  Future<void> add(ApplicationForm form) async {
    try {
      Reference? filesRef = storageRef.child("files");

      form.createdDate = DateTime.now();

      if (form.files != null) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        for (var filUrl in form.files!) {
          String filePath = '${appDocDir.absolute}/${filUrl.toString()}';
          File file = File(filePath);

          try {
            await filesRef.putFile(file);
          } on FirebaseException catch (e) {
            debugPrint(e.message);
          }
        }
      }

      return await _forms
          .add(form.toMap())
          .then((value) => print("Form Added"))
          .catchError((error) => print("Failed to add form: $error"));
    } on Exception catch (_) {
      throw Exception("Add exception");
    }
  }

  Future<void> delete(String id) async {
    await _forms
        .doc(id)
        .update({"deleted": true})
        .then((value) => print("Form deleted"))
        .catchError((error) => print("Failed to delete form: $error"));
  }

  Future<void> update(String id, ApplicationForm form) async {
    form.lastModifiedDate = DateTime.now();
    // form.updatedBy = ;

    await _forms
        .doc(id)
        .set(form.toMap())
        .then((value) => print("Form updated"))
        .catchError((error) => print("Failed to update form: $error"));
  }

  Future<List<ApplicationForm>> findByUserId(String userId) async {
    List<ApplicationForm> list = <ApplicationForm>[];

    await _forms.where("userId", isEqualTo: userId).get().then((value) =>
        value.docs.forEach((element) {
          ApplicationForm form = ApplicationForm();
          form =
              ApplicationForm.fromMap(element.data() as Map<String, dynamic>);
          list.add(form);
        }));

    if (list.isEmpty) debugPrint("empty");

    return list;
  }

  Future<List<DocumentSnapshot>> findByUserIdSnapshot(String userId) async {
    QuerySnapshot qn = await _forms.where(userId, isEqualTo: userId).get();
    return qn.docs;
  }
}
