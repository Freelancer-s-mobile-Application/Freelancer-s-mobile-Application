import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController instance = Get.find();
  // Rx<List<ChatRoom>> roomList = Rx<List<ChatRoom>>([]);
  Rx<List<types.Room>> roomList = Rx<List<types.Room>>([]);

  List<types.Room> get rooms => roomList.value;

  @override
  void onInit() {
    try {
      roomList.bindStream(FirebaseChatCore.instance.rooms());
      super.onInit();
    } catch (e) {}
  }
}
