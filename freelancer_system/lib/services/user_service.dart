// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/User.dart';

class UserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  // Future<List<User>> getUsers() async {
  //   List<User> users = newObject();
  //   final docRef = _users;
  //   docRef.get().then(
  //     (value) {
  //       for (var e in value.docs) {
  //         final data = e.data() as Map<String, dynamic>;
  //         User user = newObject();
  //         user.fromMap(data);
  //         users.add(user);
  //       }
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );

  //   users.forEach((element) {
  //     print(element.email);
  //   });

  //   return users;
  // }

  String getFirstUser() {
    String user = '';

    _users.limit(1).get().then((value) => {user = value.toString()});

    return user;
  }

  Future<void> addUser(User user) {
    return _users
        .add(user.toMap())
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // Future<void> updateUser(User user) {
  //   return _users
  //       .get().
  //       .set({
  //         'username': user.username,
  //         'email': user.email,
  //         'address': user.address,
  //         'displayname': user.displayname,
  //         'phonenumber': user.phonenumber,
  //         'description': user.description,
  //         'majorId': user.majorId
  //       })
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }

  // Future<void> deleteUser(String userId) {
  //   return _users
  //       .doc(userId)
  //       .delete()
  //       .then((value) => print("User Deleted"))
  //       .catchError((error) => print("Failed to delete user: $error"));
  // }
}
