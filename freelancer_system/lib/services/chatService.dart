import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Message.dart';
import '../models/chat_room.dart';

class ChatService {
  final CollectionReference _chat =
      FirebaseFirestore.instance.collection('Rooms');

  final user = FirebaseAuth.instance.currentUser!;

  String randomString() {
    var random = Random();
    var n = random.nextInt(1000000);
    return n.toString();
  }

  //check duplicate Room
  Future<bool> checkDuplicateRoom(List<String> mem) async {
    var snapshot =
        await _chat.where('members', arrayContainsAny: mem).get().then((value) {
      bool result = false;
      if (value.docs.isNotEmpty) {
        value.docs.map((e) {
          var r = e.data()! as dynamic;
          if (r['members'].length <= mem.length) {
            return result = false;
          } else {
            return result = true;
          }
        });
      } else {
        return result = false;
      }
      return result;
    });
    return snapshot;
  }

  Future addRoom(String rName, List<String> userAdd) async {
    String roomId = 'id', roomName = rName;
    if (roomName.isEmpty) {
      roomName = '';
      for (var a in userAdd) {
        roomName += '$a ';
      }
    }
    //create room with default roomId THEN update roomId
    await FirebaseFirestore.instance
        .collection('Rooms')
        .add(
          ChatRoom(
              roomId: roomId,
              roomName: roomName,
              createDate: DateTime.now(),
              isDeleted: false,
              lastestMsg: DateTime.now(),
              members: [user.email.toString(), ...userAdd]).toMap(),
        )
        .then(
      (e) {
        roomId = e.id;
        print('Room: $roomId');
        e.update(
          {'roomId': e.id},
        );
      },
    );
    //Add first message to room
    FirebaseAuth.instance.currentUser!.displayName;
    await FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .collection('message')
        .add(
          FreeLanceMessage(
              content:
                  '${FirebaseAuth.instance.currentUser!.displayName} created room $roomName',
              senderId: user.email.toString(),
              createdDate: DateTime.now(),
              isDeleted: false,
              seenBy: []).toMap(),
        );
  }

  Future pushChat(String roomId, String content) async {
    FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .collection('message')
        .add(FreeLanceMessage(
                isDeleted: false,
                senderId: FirebaseAuth.instance.currentUser!.email.toString(),
                seenBy: [FirebaseAuth.instance.currentUser!.email.toString()],
                content: content.isEmpty ? randomString() : content,
                createdDate: DateTime.now())
            .toMap());
    FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .update({'lastestMsg': DateTime.now()});
  }

  Future removeRoom(String roomId) async {
    await FirebaseFirestore.instance
        .collection('Rooms')
        .doc(roomId)
        .update({'isDeleted': true});
  }

  Stream<List<ChatRoom>> roomStream(String userId) {
    return _chat
        .where('members', arrayContains: userId)
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final f = ChatRoom.fromMap(doc.data() as dynamic);
              return f;
            }).toList());
  }
}
