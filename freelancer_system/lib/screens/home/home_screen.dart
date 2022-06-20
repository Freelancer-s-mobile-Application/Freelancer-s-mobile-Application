import 'package:flutter/material.dart';
import 'package:freelancer_system/screens/debug/debug.dart';
import 'package:freelancer_system/screens/settings/settings.dart';

import 'components/home_app_bar.dart';
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
  const SettingScreen()
];
