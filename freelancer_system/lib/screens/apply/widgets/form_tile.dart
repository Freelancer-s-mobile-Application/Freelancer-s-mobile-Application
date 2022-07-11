import 'package:flutter/material.dart';
import 'package:freelancer_system/services/FormService.dart';
import 'package:freelancer_system/services/PostService.dart';
import 'package:get/get.dart';

import '../../../models/Form.dart';
import '../../../models/Post.dart';
import '../../post/post_detail/post_screen.dart';
import '../view_apply.dart';

class FormTile extends StatelessWidget {
  const FormTile(this.form);

  final ApplicationForm form;

  @override
  Widget build(BuildContext context) {
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
                () => ViewApply(form),
              );
            },
            title: Text(f.data!.title.toString()),
            subtitle: Text('Status: ${form.status.toString()}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => Get.to(() => PostScreen(f.data!)),
                  icon: const Icon(Icons.view_kanban),
                ),
                IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Are you sure?',
                      content: const Text(
                          'Are you sure you want to delete this application?'),
                      actions: [
                        ElevatedButton(
                          child: const Text('Cancel'),
                          onPressed: () => Get.back(),
                        ),
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            FormService().delete(form.id.toString());
                            Get.back();
                          },
                        ),
                      ],
                    );
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
