import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../models/User.dart';

Future getUser() async {
  List<User> users = [];
  final docRef = FirebaseFirestore.instance.collection('Users');
  docRef.get().then(
    (value) {
      for (var e in value.docs) {
        // e.id; get id
        final data = e.data();
        User user = User.fromMap(data);
        print(user.toString());
        users.add(user);
      }
    },
    onError: (e) => print("Error getting document: $e"),
  );

  users.forEach((element) {
    print(element.email);
  });
}
