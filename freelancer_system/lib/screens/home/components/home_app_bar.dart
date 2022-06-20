import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/general_provider.dart';
import 'user_icon.dart';

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
      title: const Text("Home screen"),
      centerTitle: true,
      actions: [
        if (user)
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.network(
                  FirebaseAuth.instance.currentUser!.photoURL.toString()),
            ),
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
        Tab(
          text: 'Setting',
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
