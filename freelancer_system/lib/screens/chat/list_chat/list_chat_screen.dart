import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/controller.dart';
import 'components/chat_tile.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../home/components/login.dart';
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
    return Scaffold(
      floatingActionButton: addChatBtn(context),
      appBar: AppBar(
        title: const Text('Chats'),
        titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 30),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(() {
        if (authController.isLoggedIn.value) {
          return StreamBuilder<List<types.Room>>(
            stream: FirebaseChatCore.instance.rooms(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text('No chat room'),
                );
              } else {
                var rooms = snapshot.data!;
                if (rooms.isEmpty) {
                  return const Center(
                    child: Text('No chat room'),
                  );
                }
                return ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final room = rooms[index];
                    return ChatTile(room);
                  },
                );
              }
            },
          );
        } else {
          return const Center(
            child: Text('Please login to use Chat'),
          );
        }
      }),
    );
  }

  Widget addChatBtn(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn.value) {
        return FloatingActionButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => const SearchPanel(),
            );
          },
          child: const Icon(FontAwesomeIcons.solidMessage),
        );
      } else {
        return FloatingActionButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: SizedBox(
                  height: Get.height * 0.6,
                  width: Get.width * 0.9,
                  child: const LoginScreen(),
                ),
              ),
            );
          },
          child: const Icon(FontAwesomeIcons.google),
        );
      }
    });
  }
}
