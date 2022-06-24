import 'package:flutter/material.dart';
import 'package:freelancer_system/models/chat_room.dart';

import '../../../services/ChatService.dart';
import 'components/chat_panel.dart';

class DetailChatScreen extends StatelessWidget {
  const DetailChatScreen(this.room);

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    var textCtl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(room.roomName),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ChatService chatService = ChatService();
                //chatService.pushChat(room.roomId);
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatPanel(room.roomId)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration:
                BoxDecoration(border: Border.all(), color: Colors.white38),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textCtl,
                    keyboardType: TextInputType.multiline,
                    maxLength: 250,
                    maxLines: null,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue, size: 30),
                  onPressed: () {
                    ChatService().pushChat(room.roomId, textCtl.text.trim());
                    textCtl.clear();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
