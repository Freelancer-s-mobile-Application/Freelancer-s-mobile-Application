import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:freelancer_system/models/Post.dart';
import 'package:freelancer_system/services/PostService.dart';

import 'components/post_tile.dart';
import 'components/search_bar.dart';

class FreelanceScreen extends StatelessWidget {
  const FreelanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SearchBar(),
          const Divider(thickness: 1, indent: 20, endIndent: 20),
          SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.055,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Filter'),
            ),
          ),
          const Divider(thickness: 1, indent: 20, endIndent: 20),
          const ListViewBuild(),
          // const Expanded(child: ListViewBuild()),
        ],
      ),
    );
  }
}

class ListViewBuild extends StatefulWidget {
  const ListViewBuild();
  @override
  State<ListViewBuild> createState() => _ListViewBuildState();
}

class _ListViewBuildState extends State<ListViewBuild> {
  final PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postService.getAll(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: PostTile(post: snapshot.data[index]),
              );
            },
          );
        });
  }
}
