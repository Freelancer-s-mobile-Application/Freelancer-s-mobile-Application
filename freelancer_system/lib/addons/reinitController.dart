import 'package:freelancer_system/controllers/userList_controller.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

void reInitController() async {
  print('int');
  await Get.delete<UserListController>();
  await Get.delete<ChatController>();

  Get.put(UserListController());
  Get.put(ChatController());
}
