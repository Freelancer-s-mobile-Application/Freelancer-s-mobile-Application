import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  var page = 0.obs;
  var ggSignIn = GoogleSignIn().obs;
}
