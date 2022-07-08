import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatService {
  final CollectionReference _chat =
      FirebaseFirestore.instance.collection('Rooms');

  final user = FirebaseAuth.instance.currentUser!;

  Future<types.Room> createRoom(
      List<types.User> users, String title, String img) async {
    if (users.length == 1) {
      final r = await FirebaseChatCore.instance.createRoom(users[0]);
      final room = await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(r.id)
          .set({
        'name': title.isEmpty ? null : title,
        'type': 'direct',
        'imageUrl': img.isEmpty ? null : img,
        'userIds': [users[0].id, user.email],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'metadata': null,
        'userRoles': null,
      });
      return r;
    } else {
      String t = title.isEmpty ? genName(users) : title;
      if (title.isEmpty) {}
      if (img.isEmpty) {
        return await FirebaseChatCore.instance.createGroupRoom(
          users: users,
          name: t,
        );
      } else {
        return await FirebaseChatCore.instance.createGroupRoom(
          users: users,
          name: t,
          imageUrl: img,
        );
      }
    }
  }

  String genName(List<types.User> users) {
    String name = '';
    for (var user in users) {
      name += '${user.firstName}, ';
    }
    return name;
  }
}
