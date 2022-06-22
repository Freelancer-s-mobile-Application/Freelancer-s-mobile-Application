import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/chat_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(FontAwesomeIcons.solidMessage),
      ),
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: const ChatTile(),
    );
  }
}
