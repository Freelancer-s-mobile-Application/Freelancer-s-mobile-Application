import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'components/post_tile.dart';
import 'components/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List list = [1, 2, 3, 4, 5];
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
          LIstViewBuild(list),
        ],
      ),
    );
  }
}

class LIstViewBuild extends StatefulWidget {
  const LIstViewBuild(this.list);

  final List list;

  @override
  State<LIstViewBuild> createState() => _LIstViewBuildState();
}

class _LIstViewBuildState extends State<LIstViewBuild> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: widget.list[index],
          child: const PostTile(),
        );
      },
    );
  }
}
