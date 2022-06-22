import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/services/chatService.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'last_msg.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(this.roomId);

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance.collection('Rooms').doc(roomId);
    final stream = db.snapshots();
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final roomInfo = snapshot.data as dynamic;
          return Column(
            children: [
              InkWell(
                onTap: () {
                  //TODO add msg
                  ChatService chatService = ChatService();
                  //chatService.pushChat(roomId);
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Center(
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      leading: const FlutterLogo(size: 50),
                      title: Text(roomInfo['roomName']),
                      subtitle: LastMessage(roomId),
                      trailing: Text(timeago.format(
                          (roomInfo['lastestMsg'] as Timestamp).toDate())),
                    ),
                  ),
                ),
              ),
              const Divider()
            ],
          );
        }
      },
    );
    // return InkWell(
    //   onTap: () {
    //     //TODO add msg
    //     ChatService chatService = ChatService();
    //     chatService.pushChat(roomId);
    //   },
    //   child: SizedBox(
    //     height: MediaQuery.of(context).size.height * 0.08,
    //     child: Center(
    //       child: ListTile(
    //         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    //         leading: const FlutterLogo(size: 50),
    //         title: Text(roomId),
    //         subtitle: LastMessage(roomId),
    //         trailing: Text(
    //             timeago.format((roomInfo['lastestMsg'] as Timestamp).toDate())),
    //       ),
    //     ),
    //   ),
    // );
  }
}
