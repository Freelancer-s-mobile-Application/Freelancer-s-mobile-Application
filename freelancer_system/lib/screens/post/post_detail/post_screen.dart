import 'dart:async';

import 'package:flutter/material.dart';
import '../../../constants/controller.dart';
import '../../../helpers/loading.dart';
import '../../../services/PostService.dart';
import '../../../services/UserService.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../models/Post.dart';
import '../../../services/chatService.dart';
import '../../chat/chat_screen/chat_screen.dart';
import 'edit_post.dart';
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
            popMenu(context)
        ],
      ),
      body: PostDetail(_post, contact),
    );
  }

  Future btnWait() async {
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  void _editPost(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditPost(_post),
        ),
      ),
    );
  }

  var c = 5.obs;

  Widget popMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        if (value == 'edit') {
          // Get.to(EditPost(_post));
          _editPost(context);
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
    final postOwner = await UserService().findByMail(_post.userId.toString());
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
          showLoading();
          final r = await ChatService().createRoom(
              [types.User(id: postOwner.email!)], _post.title.toString(), '');
          Get.back();
          dissmissLoading();
          Get.to(() => DetailChatScreen(r.copyWith(
                name: userListController.uList
                    .firstWhere((element) => element.id == postOwner.email)
                    .firstName,
              )));
        },
        child: const Text('Yes'),
      ),
    );
  }
}
