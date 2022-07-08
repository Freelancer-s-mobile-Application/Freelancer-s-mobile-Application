// ignore_for_file: prefer_collection_literals

import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:freelancer_system/services/UserService.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../models/User.dart';

class UserListController extends GetxController {
  static UserListController instance = Get.find();
  Rx<List<FreeLanceUser>> freelanceUser = Rx<List<FreeLanceUser>>([]);
  Rx<List<types.User>> userList = Rx<List<types.User>>([]);

  List<types.User> get uList => userList.value;

  @override
  void onReady() {
    super.onReady();
    freelanceUser.bindStream(UserService().getStreamOfFreeLanceUsers());
    userList.bindStream(FirebaseChatCore.instance.users());
  }

  List<FreeLanceUser> getAll() {
    return freelanceUser.value;
  }

  // List<FreeLanceUser> getByName(String name) {
  //   return freelanceUser.value
  //       .where((user) =>
  //           user.displayname!.toLowerCase().contains(name.toLowerCase()))
  //       .toList();
  // }
  List<types.User> getByName(String name) {
    return uList
        .where((user) =>
            user.firstName!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  // List<FreeLanceUser> getByEmail(String email) {
  //   return freelanceUser.value
  //       .where((user) => user.email!.contains(email))
  //       .toList();
  // }
  List<types.User> getByEmail(String email) {
    return uList.where((user) => user.id.contains(email)).toList();
  }

  // List<FreeLanceUser> getByNameAndEmail(String name, String email) {
  //   return [...getByEmail(email), ...getByName(name)].toSet().toList();
  // }
  List<types.User> getByNameAndEmail(String name, String email) {
    print('${uList.length}');
    return [...getByEmail(email), ...getByName(name)].toSet().toList();
  }
}
