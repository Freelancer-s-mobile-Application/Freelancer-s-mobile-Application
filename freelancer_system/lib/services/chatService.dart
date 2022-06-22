import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_room.dart';
import '../models/message.dart';

class ChatService {
  final CollectionReference _chat =
      FirebaseFirestore.instance.collection('Rooms');

  final user = FirebaseAuth.instance.currentUser!;

  // Future<void> addChat() async {
  //   final room = ChatRoom(
  //       roomName: 'Demo',
  //       createDate: DateTime.now(),
  //       isDeleted: false,
  //       lastestMsg: DateTime.now(),
  //       members: [user.email.toString()]);
  //   FirebaseFirestore.instance.collection('Rooms').add(room.toMap()).then(
  //         (value) => value.collection('message').add(
  //               Message(
  //                       senderId: user.email.toString(),
  //                       seenBy: [],
  //                       message: 'Hi',
  //                       createdDate: DateTime.now())
  //                   .toMap(),
  //             ),
  //       );
  // }

  // Future pushChat(String roomId) async {
  //   FirebaseFirestore.instance
  //       .collection('Rooms')
  //       .doc(roomId)
  //       .collection('message')
  //       .add(Message(
  //               senderId: FirebaseAuth.instance.currentUser!.email.toString(),
  //               seenBy: [],
  //               message: 'Latest message',
  //               createdDate: DateTime.now())
  //           .toMap());
  //   FirebaseFirestore.instance
  //       .collection('Rooms')
  //       .doc(roomId)
  //       .update({'lastestMsg': DateTime.now()});
  // }

  Stream<List<ChatRoom>> roomStream(String userId) {
    return _chat
        .where('members', arrayContains: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final f = ChatRoom.fromMap(doc.data() as dynamic);
              print(f.toString());
              return f;
            }).toList());
  }

  Stream<Message> lastMessage(String roomId) {
    return _chat
        .doc(roomId)
        .collection('message')
        .orderBy('createdDate', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return Message.fromMap(doc.data() as dynamic);
            }).first);
  }
}
