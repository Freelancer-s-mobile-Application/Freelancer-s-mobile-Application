// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/User.dart';

class UserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('Users');

  Future<List<User>> getAll() async {
    List<User> users = <User>[];
    await _users.get().then((value) => {
          if (!value.docs.isEmpty)
            {
              for (var doc in value.docs)
                {users.add(User.fromMap(doc.data() as Map<String, dynamic>))}
            }
        });
    return users;
  }

  Future<User> find(String id) async {
    User user = User();
    await _users.doc(id).get().then(
        (value) => user = User.fromMap(value.data() as Map<String, dynamic>));
    return user;
  }

  Future<void> add(User user) async {
    return await _users
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> delete(String id) async {
    await _users
        .doc(id)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> update(String id, User user) async {
    await _users
        .doc(id)
        .update(user.toMap())
        .then((value) => print("User updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
