import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelancer_system/models/Form.dart';
import 'package:freelancer_system/models/User.dart';
import 'package:freelancer_system/services/UserService.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../constants/controller.dart';
import '../../../../helpers/loading.dart';
import '../../../../models/Post.dart';
import '../../../../services/FormService.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../../../../services/chatService.dart';
import '../../../chat/chat_screen/chat_screen.dart';

class ViewOtherApply extends StatelessWidget {
  const ViewOtherApply(this.form, this.post);

  final ApplicationForm form;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          form.userId.toString(),
          style: const TextStyle(color: Colors.blue),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.blue),
        actions: const [],
      ),
      body: FutureBuilder(
        future: UserService().findByMail(form.userId.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final FreeLanceUser user = snapshot.data! as FreeLanceUser;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textView(user.displayname.toString()),
                          textView(user.email.toString()),
                          textView(
                            UserService().getMajorName(user.majorId.toString()),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: FittedBox(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(user.avatar.toString()),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: FormService().getSpecificForm(form.id.toString()),
                    builder: (_, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        // final ApplicationForm data = ApplicationForm.fromMap(
                        //     snap.data as Map<String, dynamic>);
                        final appForm = snap.data as ApplicationForm;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                'Application Status: ${appForm.status}',
                                style: const TextStyle(fontSize: 19),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'List of files:',
                                style: TextStyle(fontSize: 19),
                              ),
                            ),
                            ...appForm.files!.map((e) {
                              String name = FormService().getFileName(e);
                              return ListTile(
                                onTap: () => openFile(e, name),
                                leading: Icon(getIcon(name)),
                                title: Text(name),
                                trailing: const Icon(Icons.open_in_full),
                              );
                            }),
                          ],
                        );
                      }
                    }),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: Get.height * 0.05,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => contact(user.email.toString()),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: Colors.pinkAccent,
                      ),
                      child: const Text('Contact Applicant'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: Get.height * 0.1,
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              primary: Colors.blue,
                            ),
                            onPressed: () => FormService()
                                .updateStatus(form.id.toString(), 'Approved'),
                            child: const Text('Approve'),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                primary: Colors.red),
                            onPressed: () => FormService()
                                .updateStatus(form.id.toString(), 'Denied'),
                            child: const Text('Deny'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  IconData getIcon(String name) {
    switch (lookupMimeType(name).toString()) {
      case 'video/mp4':
        return Icons.video_library;
      case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
        return FontAwesomeIcons.fileExcel;
      case 'application/pdf':
        return FontAwesomeIcons.filePdf;
      case 'application/vnd.android.package-archive':
        return Icons.android;
      case 'audio/mpeg':
        return FontAwesomeIcons.fileAudio;
      default:
        return Icons.attach_file;
    }
  }

  void contact(String mail) async {
    Get.defaultDialog(
      title: 'Contact this Applicant?',
      content: const Text("Do you want to contact the Applicant of this Form?"),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('No'),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          showLoading('Creating chat...');
          final r = await ChatService().createRoom(
            [types.User(id: mail)],
            post.title.toString(),
            '',
          );
          Get.back();
          dissmissLoading();
          Get.to(() => DetailChatScreen(r.copyWith(
                name: userListController.uList
                    .firstWhere((element) => element.id == mail)
                    .firstName,
              )));
        },
        child: const Text('Yes'),
      ),
    );
  }

  Text textView(String txt) => Text(txt, style: const TextStyle(fontSize: 20));

  Future openFile(String str, String name) async {
    var localPath = str;
    try {
      showLoading('Downloading...');
      final client = http.Client();
      final request = await client.get(Uri.parse(str));
      print(request.statusCode);
      final bytes = request.bodyBytes;
      final documentsDir = (await getApplicationDocumentsDirectory()).path;
      localPath = '$documentsDir/$name';
      print(localPath);
      print(File(localPath).existsSync());
      if (!File(localPath).existsSync()) {
        print('exists');
        final file = File(localPath);
        await file.writeAsBytes(bytes);
      }
    } catch (e) {
      print(e);
    } finally {
      dissmissLoading();
      await OpenFile.open(localPath);
    }
  }
}
