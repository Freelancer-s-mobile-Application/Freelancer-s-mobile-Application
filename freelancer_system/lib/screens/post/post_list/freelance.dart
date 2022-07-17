import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/post_controller.dart';
import '../../home/components/search_bar.dart';
import 'components/post_tile.dart';

class FreelanceScreen extends StatelessWidget {
  const FreelanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBar(),
        Container(
          width: double.infinity,
          height: 15,
          color: Colors.grey.withOpacity(0.1),
        ),
        const ListViewBuild(),
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
