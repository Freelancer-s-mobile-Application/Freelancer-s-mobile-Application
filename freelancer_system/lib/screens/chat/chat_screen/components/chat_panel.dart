import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPanel extends StatelessWidget {
  const ChatPanel(this.roomId);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Rooms')
          .doc(roomId)
          .collection('message')
          .orderBy('createdDate', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else {
          final messages = snapshot.data!.docs;
          // final message = messages.first.data() as dynamic;
          // return Text(
          //   message['content'],
          //   maxLines: 1,
          //   overflow: TextOverflow.ellipsis,
          // ); (e.data()! as dynamic)['content']
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              children: messages.map((e) {
                final msg = e.data()! as dynamic;
                bool isSender = msg['senderId'] == user.email;
                if (isSender) {
                  return BubbleSpecialThree(
                    text: msg['content'],
                    isSender: true,
                    color: const Color(0xFFE8E8EE),
                    sent: true,
                  );
                }
                return BubbleSpecialThree(
                  text: msg['content'],
                  color: const Color(0xFF1B97F3),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                  isSender: isSender,
                  tail: true,
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
