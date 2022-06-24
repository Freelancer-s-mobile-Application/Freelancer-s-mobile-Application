import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

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

  Future addRoom(String rName, String userAdd) async {
    String roomId = 'id', roomName = rName;
    String anotherUser = GetUtils.isEmail(userAdd) ? userAdd : '';
    //create room with default roomId THEN update roomId
    try{
    await FirebaseFirestore.instance
        .collection('Rooms')
        .add(
          ChatRoom(
              roomId: roomId,
              roomName: roomName,
              createDate: DateTime.now(),
              isDeleted: false,
              lastestMsg: DateTime.now(),
              members: [user.email.toString(), anotherUser]).toMap(),
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
    }catch (e){
    print(e);
    }
  }

  Future pushChat(String roomId, String content) async {
    try {
      FirebaseFirestore.instance
          .collection('Rooms')
          .doc(roomId)
          .collection('message')
          .add(FreeLanceMessage(
                  isDeleted: false,
                  senderId: FirebaseAuth.instance.currentUser!.email.toString(),
                  seenBy: [FirebaseAuth.instance.currentUser!.email.toString()],
                  content: content.isEmpty ? randomString() : content,
                  createdDate: DateTime.now(),
                  lastModifiedDate: DateTime.now(),
                  updatedBy:
                      FirebaseAuth.instance.currentUser?.email ?? "System")
              .toMap());
      FirebaseFirestore.instance
          .collection('Rooms')
          .doc(roomId)
          .update({'lastestMsg': DateTime.now()});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future removeRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Rooms')
          .doc(roomId)
          .update({'isDeleted': true});
    } catch (e) {
      throw Exception(e);
    }
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
