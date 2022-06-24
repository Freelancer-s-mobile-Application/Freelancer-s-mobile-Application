// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/User.dart';

class UserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('FreeLanceUsers');

  Future<FreeLanceUser> getCurrentUser() async {
    FreeLanceUser user = FreeLanceUser();

    try {
      var currentUser = FirebaseAuth.instance.currentUser!;
      if (currentUser.email == null) return user;

      await _users
          .where("email", isEqualTo: currentUser.email)
          .get()
          .then((value) {
        if (value.docs.isEmpty) {
          user = FreeLanceUser(
              email: currentUser.email,
              avatar: currentUser.photoURL,
              displayname: currentUser.displayName,
              username: currentUser.displayName,
              majorId: "SE",
              description: currentUser.displayName,
              phonenumber: currentUser.phoneNumber ?? "0123456789",
              address: currentUser.email);
          add(user);
        } else {
          user = FreeLanceUser.fromMap(
              value.docs[0].data() as Map<String, dynamic>);
        }
      });
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<List<FreeLanceUser>> getAll() async {
    List<FreeLanceUser> users = <FreeLanceUser>[];
    await _users.where("deleted", isEqualTo: false).get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {
                  users.add(
                      FreeLanceUser.fromMap(doc.data() as Map<String, dynamic>))
                }
            }
        });
    return users;
  }

  Future<FreeLanceUser> find(String id) async {
    FreeLanceUser user = FreeLanceUser();
    await _users.doc(id).get().then((value) =>
        user = FreeLanceUser.fromMap(value.data() as Map<String, dynamic>));
    return user;
  }

  Future<void> add(FreeLanceUser user) async {
    try {
      _users.where("email", isEqualTo: user.email).get().then((value) => {
            if (value.docs.isNotEmpty)
              throw Exception("Email already registrated")
          });

      DocumentReference ref = _users.doc();
      user.deleted = false;
      user.createdDate = DateTime.now();
      user.lastModifiedDate = DateTime.now();
      user.updatedBy = "System";
      user.id = ref.id;

      return await ref
          .set(user.toMap())
          .then((value) => print(user.toString()))
          .catchError((error) => print("Failed to add user: $error"));
    } on Exception catch (_) {
      throw Exception("Add exception");
    }
  }

  Future<void> delete(String id) async {
    try {
      await _users
          .doc(id)
          .update({
            "deleted": true,
            "lastModifiedDate": DateTime.now(),
            "updatedBy": "System"
          })
          .then((value) => print("FreeLanceUser deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
    } on Exception catch (_) {
      throw Exception("Delete exception");
    }
  }

  Future<void> update(String id, FreeLanceUser user) async {
    try {
      user.lastModifiedDate = DateTime.now();
      user.updatedBy = "System";

      await _users
          .doc(id)
          .update(user.toMap())
          .then((value) => print("FreeLanceUser updated"))
          .catchError((error) => print("Failed to update user: $error"));
    } on Exception catch (_) {
      throw Exception("Update exception");
    }
  }
}
