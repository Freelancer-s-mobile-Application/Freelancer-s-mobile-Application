import 'package:flutter/material.dart';
import 'package:freelancer_system/controllers/post_controller.dart';
import 'package:get/get.dart';

import 'components/post_tile.dart';
import '../../home/components/search_bar.dart';

class FreelanceScreen extends StatelessWidget {
  const FreelanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SearchBar(),
        Divider(thickness: 1, indent: 20, endIndent: 20),
        ListViewBuild(),
      ],
    );
  }
}

class ListViewBuild extends StatelessWidget {
  const ListViewBuild();

  @override
  Widget build(BuildContext context) {
    return GetX<PostController>(
      init: PostController(),
      builder: (postList) {
        var posts = postList.posts;

        if (postList.isSearch.isTrue) {
          posts = postList.search(postList.searchKey.value);
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
      },
    );
  }
}
