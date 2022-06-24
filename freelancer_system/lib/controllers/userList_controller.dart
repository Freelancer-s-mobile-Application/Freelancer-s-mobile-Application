// ignore_for_file: prefer_collection_literals

import 'package:freelancer_system/services/UserService.dart';
import 'package:get/get.dart';

import '../models/User.dart';

class UserListController extends GetxController {
  static UserListController instance = Get.find();
  Rx<List<FreeLanceUser>> freelanceUser = Rx<List<FreeLanceUser>>([]);

  @override
  void onReady() {
    super.onReady();
    freelanceUser.bindStream(UserService().getStreamOfFreeLanceUsers());
  }

  List<FreeLanceUser> getAll() {
    return freelanceUser.value;
  }

  List<FreeLanceUser> getByName(String name) {
    return freelanceUser.value
        .where((user) =>
            user.displayname!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  List<FreeLanceUser> getByEmail(String email) {
    return freelanceUser.value
        .where((user) => user.email!.contains(email))
        .toList();
  }

  List<FreeLanceUser> getByNameAndEmail(String name, String email) {
    return [...getByEmail(email), ...getByName(name)].toSet().toList();
  }
}
