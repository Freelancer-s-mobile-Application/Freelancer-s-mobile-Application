import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/controller.dart';
import 'user_icon.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar();

  @override
  Widget build(BuildContext context) {
    //final AppController getXController = Get.put(AppController());
    return AppBar(
      leading: IconButton(
        onPressed: () {
          authController.signOut();
        },
        icon: const Icon(Icons.logout),
      ),
      title: const Text("Home screen"),
      centerTitle: true,
      actions: [
        Obx(() {
          if (authController.isLoggedIn.value) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL.toString()),
              ),
            );
          } else {
            return const UserLoggedInIcon();
          }
        }),
      ],
      bottom: const TabBar(tabs: [
        Tab(
          text: 'Look For Jobs',
        ),
        Tab(
          text: 'Hire Freelancers',
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
