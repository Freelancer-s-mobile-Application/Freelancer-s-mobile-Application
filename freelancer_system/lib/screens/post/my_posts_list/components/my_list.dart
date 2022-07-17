import 'package:flutter/material.dart';
import '../../../../constants/controller.dart';
import '../../../../models/Post.dart';
import '../../../../services/PostService.dart';
import 'package:get/get.dart';

import '../../../../controllers/post_controller.dart';
import '../../post_list/components/post_tile.dart';
import 'search_myList.dart';

class MyPost extends StatelessWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn.isTrue) {
        return Column(
          children: [
            const SearchMyList(),
            Container(
              width: double.infinity,
              height: 15,
              color: Colors.grey.withOpacity(0.1),
            ),
            const MyListViewBuild(),
          ],
        );
      } else {
        return const Center(
          child: Text('Please login to see your posts'),
        );
      }
    });
  }
}

class MyListViewBuild extends StatelessWidget {
  const MyListViewBuild();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Post>>(
      stream: PostService().myPostsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var posts = snapshot.data!;
          if (Get.find<PostController>().isMySearch.isTrue) {
            posts = Get.find<PostController>()
                .searchMyList(Get.find<PostController>().mySearchKey.value);
          }
          if (posts.isEmpty) {
            return const Center(
              child: Text('No post'),
            );
          }

          return Expanded(
            child: ListView.builder(
              //physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                return PostTile(post: posts[index]);
              },
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
