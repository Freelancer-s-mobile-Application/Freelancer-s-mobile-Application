import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/controller.dart';
import '../post_create/post_create.dart';
import 'components/my_list.dart';

class MyPostList extends StatelessWidget {
  const MyPostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _addPost(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const PostCreate(),
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: Obx(() {
        if (authController.isLoggedIn.isTrue) {
          return FloatingActionButton(
            onPressed: () => _addPost(context),
            child: const Icon(Icons.add),
          );
        } else {
          return Container();
        }
      }),
      body: const Center(
        child: MyPost(),
      ),
    );
  }
}
