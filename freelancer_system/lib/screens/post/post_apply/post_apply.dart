import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/models/Post.dart';
import 'package:freelancer_system/services/FormService.dart';

import '../../../models/Form.dart';
import 'widgets/form_tile_other.dart';

class PostApply extends StatelessWidget {
  const PostApply(this.post);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.title.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.blue),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.blue,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.blue),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FormService().getMyApply(post.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('No Applications'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final ApplicationForm data = ApplicationForm.fromMap(
                  snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                );
                return FormTileOther(data, post);
              },
            );
          }
        },
      ),
    );
  }
}
