// ignore_for_file: file_names, avoid_print, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelancer_system/constants/firebase.dart';

import '../models/User.dart';

class UserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('FreeLanceUsers');

  String getMajor(String email) {
    String part = email.substring(0, email.indexOf("@"));
    String res = part.substring(0, part.length - 6);
    return res.substring(res.length - 2).toUpperCase();
  }

  String getMajorName(String major) {
    switch (major) {
      case 'se':
        return 'Software Engineering';
      case 'cs':
        return 'Computer Science';
      default:
        return 'Software Engineering';
    }
  }

  Future<FreeLanceUser> getCurrentUser() async {
    FreeLanceUser user = FreeLanceUser();
    try {
      var email = auth.currentUser?.email;
      await _users.where("email", isEqualTo: email).get().then((value) {
        user =
            FreeLanceUser.fromMap(value.docs[0].data() as Map<String, dynamic>);
      });
    } catch (e) {
      print(e);
    }
    return user;
  }

  FreeLanceUser firebaseToFreelanceUser(User user) {
    FreeLanceUser freelanceUser = FreeLanceUser();
    freelanceUser.email = user.email;
    freelanceUser.username = user.displayName;
    freelanceUser.avatar = user.photoURL;
    freelanceUser.id = user.uid;
    freelanceUser.address = 'address';
    freelanceUser.createdDate = DateTime.now();
    freelanceUser.deleted = false;
    freelanceUser.description = 'desc';
    freelanceUser.displayname = user.displayName;
    freelanceUser.majorId = '';
    freelanceUser.phonenumber = '';
    freelanceUser.updatedBy = '';
    freelanceUser.lastModifiedDate = DateTime.now();
    return freelanceUser;
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

  Future<FreeLanceUser> findById(String id) async {
    FreeLanceUser user = FreeLanceUser();
    try {
      user = await _users.doc(id).get().then((value) =>
          FreeLanceUser.fromMap(value.data() as Map<String, dynamic>));
    } on Exception {}
    return user;
  }

  Future<FreeLanceUser> findByMail(String mail) async {
    FreeLanceUser user = FreeLanceUser();
    try {
      await _users.where('email', isEqualTo: mail).get().then((value) {
        if (value.docs.isNotEmpty) {
          user = FreeLanceUser.fromMap(
              value.docs[0].data() as Map<String, dynamic>);
        }
      });
    } catch (e) {}
    return user;
  }

  Stream<List<FreeLanceUser>> getStreamOfFreeLanceUsers() {
    return _users.where("deleted", isEqualTo: false).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) =>
                FreeLanceUser.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> add(FreeLanceUser user) async {
    try {
      DocumentReference ref = _users.doc();
      user.createdDate = DateTime.now();
      user.lastModifiedDate = DateTime.now();
      user.id = ref.id;

      return await ref
          .set(user.toMap())
          .then((value) => print("FreeLanceUser Added"))
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
