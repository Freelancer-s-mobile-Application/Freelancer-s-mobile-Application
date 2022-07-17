// ignore_for_file: use_key_in_widget_constructors, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/auth_controller.dart';
import 'controllers/getX_controller.dart';
import 'firebase_options.dart';
import 'page_route.dart';
import 'screens/home/components/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await GetStorage.init();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Get.put(AuthController());
    Get.put(AppController());
  } catch (e) {}
  runApp(MyApp());
}

final navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Kanit',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Freelance System',
      navigatorKey: navKey,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snap) {
          if (snap.hasData) {
            return AppPageRoute();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
