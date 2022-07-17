// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:open_file/open_file.dart';

import '../../constants/controller.dart';
import '../../models/Form.dart';
import '../../services/FormService.dart';
import '../profile/components/user_profile.dart';

class ApplyScreen extends StatefulWidget {
  const ApplyScreen(Key? key, this.postId) : super(key: key);

  final String postId;

  @override
  State<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  late LocalAuthentication auth;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    initBio();
  }

  Future initBio() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  }

  List<String> nameList = [];
  List<String> listF = [];
  void _handleFileSelection() async {
    if (nameList.length >= 5 && listF.length >= 5) {
      Get.snackbar('Only 5 files', 'You can only submit 5 files',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: 'Select Files',
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      if (result.files.length > 5) {
        FilePicker.platform.clearTemporaryFiles();
        Get.snackbar('Only 5 files', 'You can only submit 5 files',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }
      if (listF.isNotEmpty && nameList.isNotEmpty) {
        listF = [
          ...{...listF, ...result.files.map((e) => e.path.toString())}
        ];
        nameList = [
          ...{...nameList, ...result.files.map((e) => e.name)}
        ];
        setState(() {});
      } else {
        nameList = result.files.map(((e) => e.name)).toList();
        listF = result.files.map((e) => e.path.toString()).toList();
        setState(() {});
      }
    }
  }

  void _sendForm() async {
    final result = await auth.authenticate(
      localizedReason: 'Please authenticate to send your application',
      options: const AuthenticationOptions(stickyAuth: true),
    );
    if (result) {
      try {
        if (listF.isNotEmpty && nameList.isNotEmpty) {
          ApplicationForm form = ApplicationForm(
            deleted: false,
            id: 'id',
            userId: authController.freelanceUser.value.email,
            files: listF,
            postId: widget.postId,
            updatedBy: authController.freelanceUser.value.email,
            status: 'New',
          );
          await FormService().add(form);
        } else {
          Get.snackbar(
              'You have not attach any File', 'Please select some file first',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      } finally {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply'),
        titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 30),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.blue),
        actions: [
          IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.send),
            onPressed: _sendForm,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Check your profile and information',
              style: TextStyle(fontSize: 20),
            ),
            UserProfile(key: Key(DateTime.now().toString())),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${nameList.length} file selected'),
                ElevatedButton(
                  onPressed: () {
                    _handleFileSelection();
                  },
                  child: const Text('Select CV File'),
                ),
              ],
            ),
            if (nameList.isNotEmpty)
              ...nameList.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ListTile(
                      onTap: () {
                        OpenFile.open(
                          listF.firstWhere((element) => element.contains(e)),
                        );
                      },
                      horizontalTitleGap: 0,
                      leading: const Icon(Icons.attach_file),
                      title: Text(e),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            nameList.remove(e);
                            listF.removeWhere((element) => element == e);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
