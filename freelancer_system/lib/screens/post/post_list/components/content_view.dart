import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ContentView extends StatelessWidget {
  const ContentView(this.content, {Key? key}) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    QuillController controller = QuillController.basic();
    var myJSON = jsonDecode(content);
    controller = QuillController(
      document: Document.fromJson(myJSON),
      selection: const TextSelection.collapsed(offset: 0),
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: QuillEditor.basic(
        controller: controller,
        readOnly: true, // true for view only mode
      ),
    );
  }
}
