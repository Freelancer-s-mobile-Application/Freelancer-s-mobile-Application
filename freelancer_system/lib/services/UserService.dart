// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class UserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('Users');

  Future<List<FreeLanceUser>> getAll() async {
    List<FreeLanceUser> users = <FreeLanceUser>[];
    await _users.get().then((value) => {
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
      DocumentReference ref = _users.doc();
      user.createdDate = DateTime.now();
      user.lastModifiedDate = DateTime.now();
      user.id = ref.id;

      return await ref
          .set(user.toMap())
          .then((value) => print("User Added"))
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
            // "updatedBy": "System"
          })
          .then((value) => print("User deleted"))
          .catchError((error) => print("Failed to delete user: $error"));
    } on Exception catch (_) {
      throw Exception("Delete exception");
    }
  }

  Future<void> update(String id, FreeLanceUser user) async {
    try {
      user.lastModifiedDate = DateTime.now();
      // user.updatedBy = "";

      await _users
          .doc(id)
          .update(user.toMap())
          .then((value) => print("User updated"))
          .catchError((error) => print("Failed to update user: $error"));
    } on Exception catch (_) {
      throw Exception("Update exception");
    }
  }
}
