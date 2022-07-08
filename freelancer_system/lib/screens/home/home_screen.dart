import 'package:flutter/material.dart';

import '../post/my_posts_list/my_post_list.dart';
import 'components/home_app_bar.dart';
import '../post/post_list/freelance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: screenList.length,
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: TabBarView(children: [...screenList.toList()]),
      ),
    );
  }
}

List<Widget> screenList = [const FreelanceScreen(), const MyPostList()];
