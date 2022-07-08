import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class LastMessage extends StatelessWidget {
  const LastMessage(this.room);

  final types.Room room;

  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance
        .collection('ChatRooms/${room.id}/messages')
        .where('type', isEqualTo: 'text')
        .orderBy('createdAt', descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('...');
          } else if (!snapshot.hasData) {
            return const Text('...');
          } else {
            final messages = snapshot.data!.docs;
            if (messages.isEmpty) {
              return const Text(
                '...',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            }
            final msg = (messages.first.data() as Map<String, dynamic>);
            if (msg['type'] == 'text') {
              return Text(
                (messages.first.data() as Map<String, dynamic>)['text'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            } else if (msg['type'] == 'image') {
              return const Text(
                'photo',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            } else {
              return const Text(
                '...',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            }
          }
        });
  }
}
