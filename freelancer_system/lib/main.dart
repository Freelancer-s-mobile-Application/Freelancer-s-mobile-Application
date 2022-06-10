// ignore_for_file: use_key_in_widget_constructors, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancer_system/screens/home/home_screen.dart';
import 'package:freelancer_system/screens/profile/profile.dart';

import 'components/general_provider.dart';
import 'firebase_options.dart';
import 'screens/home/components/user_icon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {}
  runApp(ProviderScope(child: MyApp()));
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      navigatorKey: navKey,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

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
  const HomeScreen(),
  const ProfileScreen(),
  //const SettingScreen(),
];

class HomeAppBar extends ConsumerWidget with PreferredSizeWidget {
  const HomeAppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return AppBar(
      title: const Text('Home Screen'),
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
          text: 'Projects',
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
