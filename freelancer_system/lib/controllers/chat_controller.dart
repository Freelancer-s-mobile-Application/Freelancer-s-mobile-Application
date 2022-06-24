import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/chat_room.dart';
import '../services/chatService.dart';

class ChatController extends GetxController {
  Rx<List<ChatRoom>> roomList = Rx<List<ChatRoom>>([]);

  List<ChatRoom> get rooms => roomList.value;

  @override
  void onInit() {
    final userMail = FirebaseAuth.instance.currentUser!.email.toString();
    roomList.bindStream(ChatService().roomStream(userMail));
    super.onInit();
  }
}
