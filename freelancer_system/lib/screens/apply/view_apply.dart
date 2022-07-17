import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/helpers/loading.dart';
import 'package:freelancer_system/models/Form.dart';
import 'package:freelancer_system/services/FormService.dart';
import 'package:freelancer_system/services/PostService.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../models/Post.dart';
import 'package:http/http.dart' as http;

import '../../models/User.dart';
import '../../services/UserService.dart';

class ViewApply extends StatelessWidget {
  const ViewApply(this.form);

  final ApplicationForm form;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: FutureBuilder<Post>(
          future: PostService().find(form.postId.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text('No Post'),
              );
            }
            FreeLanceUser user = authController.freelanceUser.value;
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Application Status: ${form.status.toString()}',
                    style: GoogleFonts.kanit(fontSize: 19),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'List of your files:',
                    style: GoogleFonts.kanit(fontSize: 19),
                  ),
                ),
                ...form.files!.map((e) {
                  String name = FormService().getFileName(e);
                  return ListTile(
                    onTap: () => openFile(e, name),
                    leading: Icon(getIcon(name)),
                    title: Text(name),
                    trailing: const Icon(Icons.open_in_full),
                  );
                })
              ],
            );
          }),
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

  Text textView(String txt) =>
      Text(txt, style: GoogleFonts.kanit(fontSize: 20));

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
