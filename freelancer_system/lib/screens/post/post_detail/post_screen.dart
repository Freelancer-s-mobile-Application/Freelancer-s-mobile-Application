import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/helpers/loading.dart';
import 'package:freelancer_system/screens/chat/chat_screen/chat_screen.dart';
import 'package:freelancer_system/services/PostService.dart';
import 'package:freelancer_system/services/UserService.dart';
import 'package:freelancer_system/services/chatService.dart';
import 'package:get/get.dart';

import '../../../models/Post.dart';
import 'post_detail.dart';

class PostScreen extends StatelessWidget {
  PostScreen(this._post);

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
          if (_post.userId != authController.freelanceUser.value.email)
            IconButton(
              onPressed: () {
                contact();
              },
              icon: const Icon(Icons.message),
            ),
          if (_post.userId == authController.freelanceUser.value.email)
            popMenu()
        ],
      ),
      body: PostDetail(_post),
    );
  }

  Future btnWait() async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  var c = 10.obs;

  Widget popMenu() {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        if (value == 'edit') {
          //edit post
        } else if (value == 'delete') {
          Get.defaultDialog(
            title: 'Delete Post',
            content: const Text('Are you sure you want to delete this post?'),
            confirm: Obx(() {
              Timer.periodic(const Duration(milliseconds: 1000), (Timer t) {
                if (c.value == 0) {
                  t.cancel();
                } else {
                  c.value--;
                }
              });
              if (c.value == 0) {
                return ElevatedButton(
                  onPressed: () {
                    PostService().delete(_post.id.toString()).then((value) {
                      Get.back();
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text('Confirm'),
                );
              } else {
                return ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  child: Text('Confirm... (${c.value})'),
                );
              }
            }),
            cancel: TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit Post'),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete Post'),
        ),
      ],
    );
  }

  void contact() async {
    final currentMail = authController.freelanceUser.value.email;
    final postOwner = await UserService().findById(_post.userId.toString());
    Get.defaultDialog(
      title: 'Contact this post owner?',
      content: const Text("Do you want to contact the owner of this post?"),
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
