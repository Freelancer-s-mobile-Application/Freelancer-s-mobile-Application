// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/chat_controller.dart';
import '../controllers/getX_controller.dart';
import '../controllers/post_controller.dart';
import '../controllers/userList_controller.dart';
import '../models/User.dart';

Future getUser() async {
  List<FreeLanceUser> users = [];
  final docRef = FirebaseFirestore.instance.collection('Users');
  docRef.get().then(
    (value) {
      for (var e in value.docs) {
        // e.id; get id
        final data = e.data();
        FreeLanceUser user = FreeLanceUser.fromMap(data);
        users.add(user);
      }
    },
    onError: (e) => print("Error getting document: $e"),
  );
}

void initGlobal() {
  final AppController appController = Get.put(AppController());
  final AuthController authController = Get.put(AuthController());
  final UserListController userListController = Get.put(UserListController());
  final ChatController chatController = Get.put(ChatController());
  final PostController postController = Get.put(PostController());
}
