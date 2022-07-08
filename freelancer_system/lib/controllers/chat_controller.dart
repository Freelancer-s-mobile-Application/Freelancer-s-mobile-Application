import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatController extends GetxController {
  static ChatController instance = Get.find();
  // Rx<List<ChatRoom>> roomList = Rx<List<ChatRoom>>([]);
  Rx<List<types.Room>> roomList = Rx<List<types.Room>>([]);

  List<types.Room> get rooms => roomList.value;

  @override
  void onInit() {
    try {
      final userMail = FirebaseAuth.instance.currentUser!.email.toString();
      // roomList.bindStream(ChatService().roomStream(userMail));
      roomList.bindStream(FirebaseChatCore.instance.rooms());
      super.onInit();
    } catch (e) {}
  }
}
