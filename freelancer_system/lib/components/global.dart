// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/User.dart';

Future getUser() async {
  List<FreeLanceUser> users = [];
  final docRef = FirebaseFirestore.instance.collection('Users');
  docRef.get().then(
    (value) {
      for (var e in value.docs) {
        // e.id; get id
        final data = e.data();
        FreeLanceUser user = FreeLanceUser.fromMap(data);
        users.add(user);
      }
    },
    onError: (e) => print("Error getting document: $e"),
  );

  for (var element in users) {
    print(element.email);
  }
}
