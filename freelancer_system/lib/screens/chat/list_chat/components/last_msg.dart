import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LastMessage extends StatelessWidget {
  const LastMessage(this.roomId);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('Rooms').doc(roomId);
    final stream = db
        .collection('message')
        .orderBy('createdDate', descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final messages = snapshot.data!.docs;
          final message = messages.first.data() as dynamic;
          return Text(
            message['message'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }
      },
    );
  }
}
