import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelancer_system/screens/chat/list_chat/components/chat_tile.dart';
import 'package:get/get.dart';

import '../../../controllers/chat_controller.dart';
import 'components/search_panel.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  String randomString() {
    final random = Random();
    final str =
        String.fromCharCodes(List.generate(10, (index) => random.nextInt(256)));
    return str;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return user == null
        ? const Center(
            child: Text('Please login to use Chat'),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                // ChatService().addRoom(randomString());
                showDialog(
                  context: context,
                  builder: (context) => const SearchPanel(),
                );
              },
              child: const Icon(FontAwesomeIcons.solidMessage),
            ),
            appBar: AppBar(
              title: const Text('Chats'),
              centerTitle: true,
            ),
            body: GetX<ChatController>(
              init: ChatController(),
              builder: (roomList) {
                return ListView.builder(
                  itemCount: roomList.rooms.length,
                  itemBuilder: (context, index) {
                    final room = roomList.rooms[index];
                    return ChatTile(room);
                  },
                );
              },
            ),
          );
  }
}
