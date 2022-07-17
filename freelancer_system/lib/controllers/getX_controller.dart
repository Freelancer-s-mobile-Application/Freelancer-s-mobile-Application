import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();
  var page = 0.obs;
  var ggSignIn = GoogleSignIn().obs;

  final Rx<double> _progress = RxDouble(0);
  double get progress => _progress.value;
  set progress(double d) => _progress.value = d;
}
