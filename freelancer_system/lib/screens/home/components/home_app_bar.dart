import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/getX_controller.dart';
import 'user_icon.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar();

  @override
  Widget build(BuildContext context) {
    final AppController getXController = Get.put(AppController());
    final user = getXController.isUserLoggedIn.value;
    return AppBar(
      leading: IconButton(
        onPressed: () {
          print(user);
          FirebaseAuth.instance.signOut();
          getXController.isUserLoggedIn.value = false;
          getXController.ggSignIn.value.signOut();
        },
        icon: const Icon(Icons.logout),
      ),
      title: const Text("Home screen"),
      centerTitle: true,
      actions: [
        Obx(() {
          if (getXController.isUserLoggedIn.value) {
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
