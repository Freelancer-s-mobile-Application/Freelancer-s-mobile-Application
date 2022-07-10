import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/screens/profile/profile.dart';
import 'package:get/get.dart';

import 'components/global.dart';
import 'constants/controller.dart';
import 'screens/chat/list_chat/list_chat_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/settings.dart';

class AppPageRoute extends StatelessWidget {
  AppPageRoute();

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Widget getScreen(int i) {
    switch (i) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ChatScreen();
      case 2:
        return const ProfileScreen();
      case 3:
        return const SettingScreen();
      default:
        return const HomeScreen();
    }
  }

  final init = initGlobal();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: appController.page.value,
          height: 60.0,
          color: Colors.white,
          buttonBackgroundColor: Colors.white38,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOutCubic,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) => appController.page.value = index,
          letIndexChange: (index) => true,
          items: <Widget>[
            const Icon(Icons.home, size: 30),
            const Icon(Icons.message, size: 30),
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
                return const Icon(Icons.person, size: 30);
              }
            }),
            const Icon(Icons.settings, size: 30),
          ],
        ),
        body: getScreen(appController.page.value),
      ),
    );
  }
}
