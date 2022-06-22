import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/services/chatService.dart';
import 'package:get/get.dart';

import '../../../controllers/chat_controller.dart';
import 'components/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: const Center(
          child: Text(
            'Please login to see your chats',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      );
    }
    final stream = FirebaseFirestore.instance
        .collection('Rooms')
        .where('members', arrayContains: user.email)
        .snapshots();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ChatService chatService = ChatService();
          //TODO: Add new chat
          //this just a dummy way to add new chat
          chatService.addChat();
          final ChatController cc = Get.find<ChatController>();
          cc.printLength();
        },
        child: const Icon(Icons.search_outlined),
      ),
      appBar: AppBar(
        title: const Text('Chat Rooms'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'No Text Messages',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((e) {
                if ((e.data() as dynamic)['isDeleted'] == false) {
                  return ChatTile(e.id);
                } else {
                  return Container();
                }
              }).toList(),
            );
          }
        },
      ),
      // body: SafeArea(
      //   child: GetX<ChatController>(
      //       init: Get.put(ChatController()),
      //       builder: (roomController) {
      //         if (roomController.rooms.isNotEmpty) {
      //           return ListView.builder(
      //             itemCount: roomController.rooms.length,
      //             itemBuilder: (_, i) {
      //               return ChatTile(roomController.rooms[i]);
      //             },
      //           );
      //         } else {
      //           return const Center(
      //             child: Text('Loading...'),
      //           );
      //         }
      //       }),
      // ),
    );
  }
}
