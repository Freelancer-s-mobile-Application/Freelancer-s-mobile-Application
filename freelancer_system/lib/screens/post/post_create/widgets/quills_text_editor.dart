import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../../constants/controller.dart';
import 'Ftext.dart';
import 'package:get/get.dart';

class QuillsTextEditor extends StatefulWidget {
  QuillsTextEditor(this.myContent);

  String myContent;

  @override
  State<QuillsTextEditor> createState() => _QuillsTextEditorState();
}

class _QuillsTextEditorState extends State<QuillsTextEditor> {
  QuillController _controller = QuillController.basic();

  Future save() async {
    curContent = postController.postContent.value = jsonEncode(
      _controller.document.toDelta(),
    );
    Get.snackbar(
      'Content Saved',
      'Content Saved Successfully',
      colorText: Colors.black,
      backgroundColor: Colors.white,
    );
  }

  String curContent = '';

  Future<bool> onLeave() async {
    if (curContent != postController.postContent.value) {
      Get.defaultDialog(
        title: 'Saves not saved',
        content: const FText(
            'Do you want to save your changes? You will lost them if you leave this page.'),
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            Get.back();
            save();
          },
          child: const FText('Save and Exit'),
        ),
        cancel: TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: const FText('Exit without saving'),
        ),
      );
    } else {
      Get.back();
    }
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    try {
      if (widget.myContent.isEmpty) {
      } else {
        curContent = widget.myContent;
        var content = jsonDecode(widget.myContent);
        _controller = QuillController(
          document: Document.fromJson(content),
          selection: const TextSelection.collapsed(offset: 0),
        );
      }
    } catch (e) {}
    _controller.addListener(() {
      curContent = jsonEncode(_controller.document.toDelta());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onLeave(),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              onLeave();
            },
          ),
          title: const FText('Content Editor'),
          actions: [
            IconButton(
              onPressed: () => save(),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              QuillToolbar.basic(controller: _controller),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(border: Border.all()),
                  child: QuillEditor.basic(
                    controller: _controller,
                    readOnly: false, // true for view only mode
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
