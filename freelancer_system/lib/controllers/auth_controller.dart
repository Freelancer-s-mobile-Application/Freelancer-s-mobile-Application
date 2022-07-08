import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/helpers/loading.dart';
import 'package:freelancer_system/models/User.dart';
import 'package:freelancer_system/services/UserService.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../constants/firebase.dart';
import 'getX_controller.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseuser;
  Rx<FreeLanceUser> freelanceUser = Rx<FreeLanceUser>(FreeLanceUser());
  Rx<types.User> chatUser = Rx<types.User>(const types.User(id: ''));
  RxBool isLoggedIn = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseuser = Rx<User?>(auth.currentUser);
    firebaseuser.bindStream(auth.userChanges());
    ever(firebaseuser, _setIsLogged);
  }

  _setIsLogged(User? user) {
    if (user == null) {
      isLoggedIn.value = false;
    } else {
      checkUserExist();
      isLoggedIn.value = true;
    }
  }

  Future signInWithGoogle() async {
    try {
      final ggSignIn = appController.ggSignIn.value;
      showLoading();
      final GoogleSignInAccount? googleUser = await ggSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.back();
      Get.back();
    } on FirebaseAuthException {
      Get.snackbar(
        'Error',
        'Error signing in with Google',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  checkUserExist() async {
    UserService userService = UserService();
    final FreeLanceUser user =
        await userService.findByMail(firebaseuser.value!.email.toString());
    if (user.id == null) {
      Get.snackbar(
        'Welcome New User',
        'Welcome to Freelancer System',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );

      final newUser = userService.firebaseToFreelanceUser(firebaseuser.value!);
      userService.add(newUser);
      await FirebaseChatCore.instance.createUserInFirestore(
        chatUser.value = types.User(
          firstName: newUser.displayname,
          id: newUser.email.toString(),
          imageUrl: newUser.avatar,
        ),
      );
      freelanceUser.value = newUser;
    } else {
      Get.snackbar(
        'Welcome Back',
        'Welcome back to Freelancer System',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        chatUser.value = types.User(
          firstName: user.displayname,
          id: user.email.toString(),
          imageUrl: user.avatar,
        ),
      );
      freelanceUser.value = user;
    }
  }

  void signOut() {
    try {
      final AppController getXController = Get.find();
      getXController.ggSignIn.value.signOut();
      auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
