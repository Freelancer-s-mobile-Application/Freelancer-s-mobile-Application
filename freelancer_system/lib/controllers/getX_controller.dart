import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppController extends GetxController {
  var page = 0.obs;
  var isUserLoggedIn = false.obs;
  var ggSignIn = GoogleSignIn().obs;
}
