import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../addons/user_avatar.dart';
import '../../../../constants/controller.dart';
import '../../chat_screen/chat_screen.dart';
import 'last_msg.dart';

class ChatTile extends StatelessWidget {
  const ChatTile(this.room);

  final types.Room room;

  Future renderChatTile() async {
    return await Future.delayed(const Duration(milliseconds: 300));
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;
    types.User otherUser = const types.User(id: '');
    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != authController.chatUser.value.id,
        );
        color = getUserAvatarNameColor(otherUser);
      } catch (e) {}
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';
    var list = room.users
      ..removeWhere(
          (element) => element.id == authController.chatUser.value.id);

    String url = list[0].imageUrl.toString();
    return Container(
      margin: const EdgeInsets.only(left: 8),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage
            ? NetworkImage(url)
            : const NetworkImage(
                'https://w7.pngwing.com/pngs/595/79/png-transparent-dart-programming-language-flutter-object-oriented-programming-flutter-logo-class-fauna-bird.png'),
        radius: 30,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String name = '';
    if (room.users.length == 2) {
      name = room.users
          .firstWhere((u) => u.id != authController.chatUser.value.id)
          .firstName
          .toString();
    } else {
      name = room.name ?? '';
    }

    return InkWell(
      onTap: () {
        Get.to(() => DetailChatScreen(room));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: Center(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            leading: _buildAvatar(room),
            title: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: LastMessage(room),
            trailing: Text(timeAGO()),
          ),
        ),
      ),
    );
  }

  String timeAGO() {
    if (room.updatedAt == null) {
      return timeago.format(DateTime.now());
    }
    return timeago.format(
      DateTime.fromMillisecondsSinceEpoch(room.updatedAt!),
    );
  }
}
