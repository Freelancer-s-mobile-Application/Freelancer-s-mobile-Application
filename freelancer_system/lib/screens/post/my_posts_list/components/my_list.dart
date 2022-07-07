import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../../controllers/post_controller.dart';
import '../../post_list/components/post_tile.dart';
import 'search_myList.dart';

class MyPost extends StatelessWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SearchMyList(),
        Divider(thickness: 1, indent: 20, endIndent: 20),
        MyListViewBuild(),
      ],
    );
  }
}

class MyListViewBuild extends StatelessWidget {
  const MyListViewBuild();

  @override
  Widget build(BuildContext context) {
    return GetX<PostController>(
      init: PostController(),
      builder: (postList) {
        var posts = postList.myPosts.value;

        if (postList.isMySearch.isTrue) {
          posts = postList.searchMyList(postList.mySearchKey.value);
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
              return AnimationConfiguration.staggeredList(
                position: index,
                child: PostTile(post: posts[index]),
              );
            },
          ),
        );
      },
    );
  }
}
