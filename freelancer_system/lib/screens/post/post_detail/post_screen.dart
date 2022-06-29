import 'package:flutter/material.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/helpers/loading.dart';
import 'package:freelancer_system/screens/chat/chat_screen/chat_screen.dart';
import 'package:freelancer_system/services/UserService.dart';
import 'package:freelancer_system/services/chatService.dart';
import 'package:get/get.dart';

import '../../../models/Post.dart';
import 'post_detail.dart';

class PostScreen extends StatelessWidget {
  const PostScreen(this._post);

  final Post _post;

  @override
  Widget build(BuildContext context) {
    //return a detail page
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _post.title.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              contact();
            },
            icon: const Icon(Icons.message),
          ),
        ],
      ),
      body: PostDetail(_post),
    );
  }

  void contact() async {
    final currentMail = authController.freelanceUser.value.email;
    final postOwner = await UserService().findById(_post.userId.toString());
    Get.defaultDialog(
      title: 'Contact this post owner?',
      content: const Text("'Do you want to contact this post'"),
      cancel: ElevatedButton(
        onPressed: () {
          dissmissLoading();
        },
        child: const Text('No'),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          final roomId = await ChatService().addRoom(_post.title.toString(),
              [currentMail.toString(), postOwner.email.toString()]);
          final chatRoom = await ChatService().getRoom(roomId);
          Get.back();
          Get.to(() => DetailChatScreen(chatRoom));
        },
        child: const Text('Yes'),
      ),
    );
  }
}
