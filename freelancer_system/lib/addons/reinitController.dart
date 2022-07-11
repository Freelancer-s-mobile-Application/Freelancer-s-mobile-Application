import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../controllers/userList_controller.dart';

void reInitController() async {
  await Get.delete<UserListController>();
  await Get.delete<ChatController>();

  Get.put(UserListController());
  Get.put(ChatController());
}
