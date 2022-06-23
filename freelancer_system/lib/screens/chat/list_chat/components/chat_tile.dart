import 'package:flutter/material.dart';
import 'package:freelancer_system/models/chat_room.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../services/ChatService.dart';
import '../../chat_screen/chat_screen.dart';
import 'last_msg.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(this.room);

  final ChatRoom room;

  Future renderChatTile() async {
    print('delay');
    return await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    // final db = FirebaseFirestore.instance.collection('Rooms').doc(room.roomId);
    // final stream = db.snapshots();
    // var roomName = 'Loading...';
    // return StreamBuilder(
    //   stream: stream,
    //   builder: (context, snapshot) {
    //     final roomInfo = snapshot.data as dynamic;
    //     return Column(
    //       children: [
    //         InkWell(
    //           onTap: () {
    //             //TODO navigate to chat
    //             ChatService chatService = ChatService();
    //             chatService.pushChat(room.roomId);
    //           },
    //           child: SizedBox(
    //             height: MediaQuery.of(context).size.height * 0.08,
    //             child: Center(
    //               child: ListTile(
    //                 contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    //                 leading: const FlutterLogo(size: 50),
    //                 title: Text(roomInfo['roomName']),
    //                 subtitle: LastMessage(room.roomId),
    //                 trailing: Text(timeago.format(
    //                     (roomInfo['lastestMsg'] as Timestamp).toDate())),
    //               ),
    //             ),
    //           ),
    //         ),
    //         const Divider()
    //       ],
    //     );
    //   },
    // );
    return InkWell(
      onTap: () {
        // ChatService chatService = ChatService();
        // chatService.pushChat(room.roomId);
        Get.to(DetailChatScreen(room));
      },
      onLongPress: () {
        ChatService chatService = ChatService();
        chatService.removeRoom(room.roomId);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: const FlutterLogo(size: 50),
            title: Text(room.roomName),
            subtitle: LastMessage(room.roomId),
            trailing: Text(timeago.format((room.lastestMsg))),
          ),
        ),
      ),
    );
  }
}
