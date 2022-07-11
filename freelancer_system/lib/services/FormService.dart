// ignore_for_file: file_names, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/helpers/loading.dart';
import 'package:freelancer_system/models/Form.dart';
import 'package:get/get.dart';

class FormService {
  final CollectionReference _forms =
      FirebaseFirestore.instance.collection('Forms');

  final storageRef = FirebaseStorage.instance;

  Future<ApplicationForm> find(String id) async {
    ApplicationForm form = ApplicationForm();

    try {
      await _forms.doc(id).get().then((value) =>
          form = ApplicationForm.fromMap(value.data() as Map<String, dynamic>));
    } on Exception catch (_) {
      throw Exception("Add exception");
    }
    return form;
  }

  Future<void> add(ApplicationForm form) async {
    showLoading('Uploading...');
    String idKey = genIdKey(form);
    try {
      form.createdDate = DateTime.now();
      List<String> urls = [];

      if (form.files != null) {
        // Directory appDocDir = await getApplicationDocumentsDirectory();
        for (var filUrl in form.files!) {
          final fileName = filUrl.split("/").last;
          String filePath = filUrl.toString();
          File file = File(filePath);
          try {
            Reference? filesRef = storageRef.ref(form.userId).child(fileName);
            await filesRef
                .putFile(file)
                .then((p0) async => urls.add(await p0.ref.getDownloadURL()));
          } on FirebaseException catch (e) {
            debugPrint(e.message);
          }
        }
      }

      return await _forms
          .doc(idKey)
          .set(form
              .copyWith(
                  files: urls, id: idKey, lastModifiedDate: DateTime.now())
              .toMap())
          .catchError((error) => print("Failed to add form: $error"));
    } on Exception catch (_) {
      throw Exception("Add exception");
    } finally {
      dissmissLoading();
      dissmissLoading();
      Get.snackbar('Success', 'Your application has been sent',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
  }

  Future<bool> checkExist(String idKey) async {
    bool exist = false;
    try {
      await _forms.doc(idKey).get().then((value) => exist = value.exists);
    } on Exception catch (_) {
      throw Exception("Add exception");
    }
    return exist;
  }

  String genIdKey(ApplicationForm form) {
    return '${form.userId}_${form.postId}';
  }

  Future<void> delete(String id) async {
    await _forms
        .doc(id)
        .update({"deleted": true})
        .then((value) => print("Form deleted"))
        .catchError((error) => print("Failed to delete form: $error"));
  }

  String getFileName(String url) {
    return storageRef.refFromURL(url).name;
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
    QuerySnapshot qn;
    try {
      qn = await _forms.where(userId, isEqualTo: userId).get();
    } catch (e) {
      throw Exception(e);
    }
    return qn.docs;
  }

  Stream<QuerySnapshot> getStream() {
    return _forms
        .where(
          'userId',
          isEqualTo: authController.firebaseuser.value!.email.toString(),
        )
        .where('deleted', isEqualTo: false)
        .snapshots();
  }
}
