import 'package:get_storage/get_storage.dart';

import '../controllers/auth_controller.dart';
import '../controllers/chat_controller.dart';
import '../controllers/getX_controller.dart';
import '../controllers/post_controller.dart';
import '../controllers/userList_controller.dart';

AppController appController = AppController.instance;
AuthController authController = AuthController.instance;
UserListController userListController = UserListController.instance;
ChatController chatController = ChatController.instance;
PostController postController = PostController.instance;

GetStorage box = GetStorage();
