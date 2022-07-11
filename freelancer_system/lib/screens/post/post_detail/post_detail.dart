import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/services/FormService.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/Post.dart';
import '../../apply/apply.dart';
import '../post_list/components/content_view.dart';

class PostDetail extends StatelessWidget {
  const PostDetail(this._post, this.func);

  final Post _post;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _post.title.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 1,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _post.status.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.user,
                      size: 13,
                      color: Colors.blue,
                    ),
                    if (int.parse(_post.min.toString()) ==
                        int.parse(_post.max.toString()))
                      Text(
                        ' ${_post.min} needed',
                        style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    if (int.parse(_post.min.toString()) !=
                        int.parse(_post.max.toString()))
                      Text(
                        " ${_post.min} - ${_post.max} needed",
                        style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                  ],
                )
              ],
            ),
            const Divider(thickness: 2),
            ContentView(
              _post.content.toString(),
            ),
            const Divider(),
            Obx(() {
              if (!authController.isLoggedIn.value) {
                return Text(
                  'Please login to apply',
                  style: GoogleFonts.kanit(fontSize: 20),
                );
              } else {
                return Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () async {
                          String uMail = authController
                              .freelanceUser.value.email
                              .toString();
                          if (_post.userId == uMail) {
                            Get.snackbar(
                              'You can not apply to your own Post',
                              'Self-apply is not allowed',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              borderRadius: 10,
                              margin: const EdgeInsets.all(10),
                              borderColor: Colors.red,
                              colorText: Colors.white,
                              borderWidth: 2,
                              duration: const Duration(seconds: 3),
                              icon: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            String idKey = '${uMail}_${_post.id.toString()}';
                            print(idKey);
                            bool checkIsExist =
                                await FormService().checkExist(idKey);
                            if (checkIsExist) {
                              Get.snackbar('Error',
                                  'You have already applied for this post',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  icon: const Icon(
                                    Icons.error,
                                    color: Colors.white,
                                  ));
                            } else {
                              Get.to(
                                () => ApplyScreen(
                                    UniqueKey(), _post.id.toString()),
                              );
                            }
                          }
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          String uMail = authController
                              .freelanceUser.value.email
                              .toString();
                          if (_post.userId == uMail) {
                            Get.snackbar('Say hello to yourself?',
                                'You can not start a chat with yourself',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                borderRadius: 10,
                                margin: const EdgeInsets.all(10),
                                borderColor: Colors.red,
                                borderWidth: 2,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 3),
                                icon: const Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ));
                          } else {
                            func();
                          }
                        },
                        child: const Text(
                          'Contact Project Owner',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
