import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/global.dart';
import '../../constants/controller.dart';
import '../../models/User.dart';
import '../apply/myApplication.dart';
import 'components/option_tile.dart';
import 'components/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isLoggedIn.value) {
        bool isEdit = authController.isEditable.value;
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: isEdit
                  ? IconButton(
                      onPressed: () {
                        FreeLanceUser user = authController.freelanceUser.value;
                        phoneCtl.text = user.phonenumber.toString();
                        addrCtl.text = user.address.toString();
                        descCtl.text = user.description.toString();
                        authController.isEditable.value = false;
                      },
                      icon: const Icon(Icons.cancel, color: Colors.black),
                    )
                  : null,
              actions: [
                IconButton(
                  onPressed: () {
                    if (isEdit) {
                      if (authController.key.value.currentState!.validate()) {
                        authController.key.value.currentState!.save();
                        authController.isEditable.toggle();
                      } else {}
                    } else {
                      authController.isEditable.toggle();
                    }
                  },
                  icon: isEdit
                      ? const Icon(
                          Icons.save,
                          color: Colors.black,
                        )
                      : const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Get.height * 0.15,
                    child: FittedBox(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Image.network(
                            FirebaseAuth.instance.currentUser!.photoURL
                                .toString(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const UserProfile(),
                  OptionTile(Icons.note_alt, 'My Applications', Colors.blue,
                      () {
                    Get.to(() => const MyApplicationsScreen());
                  }),
                  OptionTile(Icons.logout, 'Logout', Colors.cyan, () {
                    authController.signOut();
                  }),
                ],
              ),
            ),
          ),
        );
      } else {
        return const Center(
          child: Text('Please login to see your profile'),
        );
      }
    });
  }
}
