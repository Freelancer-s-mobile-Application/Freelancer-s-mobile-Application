import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/getX_controller.dart';
import 'main.dart';
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
        return const SettingScreen();
      default:
        return const HomeScreen();
    }
  }

  final AppController getXController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      navigatorKey: navKey,
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) => getXController.page.value = index,
          letIndexChange: (index) => true,
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.message, size: 30),
            Icon(Icons.settings, size: 30),
          ],
        ),
        body: Obx(() => getScreen(getXController.page.value)),
      ),
    );
  }
}