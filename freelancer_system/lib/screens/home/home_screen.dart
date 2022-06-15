import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancer_system/screens/debug/debug.dart';
import 'package:freelancer_system/screens/settings/settings.dart';
import 'package:freelancer_system/services/user_service.dart';

import '../../components/general_provider.dart';
import '../profile/profile.dart';
import 'components/user_icon.dart';
import 'freelance.dart';

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

List<Widget> screenList = [
  const FreelanceScreen(),
  const DebugScreen(),
  //const SettingScreen(),
];

class HomeAppBar extends ConsumerWidget with PreferredSizeWidget {
  const HomeAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final UserService userService = UserService();

    final user = ref.watch(userProvider);
    return AppBar(
      leading: IconButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          ref.read(googleSignInProvider.notifier).state.signOut();
          ref.refresh(userProvider);
        },
        icon: const Icon(Icons.logout),
      ),
      title: Text("Home screen"),
      centerTitle: true,
      actions: [
        if (user)
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.network(
                FirebaseAuth.instance.currentUser!.photoURL.toString()),
          ),
        if (!user) const UserLoggedInIcon(),
      ],
      bottom: const TabBar(tabs: [
        Tab(
          text: 'Freelancers',
        ),
        Tab(
          text: 'Debug',
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
