import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/Form.dart';
import '../../../../models/Post.dart';
import '../../../../services/PostService.dart';
import '../screens/view_other_apply.dart';

class FormTileOther extends StatelessWidget {
  const FormTileOther(this.form, this.post);

  final ApplicationForm form;
  final Post post;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy-MM-dd');
    return FutureBuilder<Post>(
      future: PostService().find(form.postId.toString()),
      builder: (_, f) {
        if (f.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (f.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (f.data == null) {
          return const Center(
            child: Text('No Post'),
          );
        } else {
          return ListTile(
            onTap: () {
              Get.to(
                () => ViewOtherApply(form, post),
              );
            },
            title: Text(form.userId.toString()),
            subtitle: Text('Status: ${form.status.toString()}'),
            trailing: Text(formatter.format(form.createdDate!)),
          );
        }
      },
    );
  }
}
