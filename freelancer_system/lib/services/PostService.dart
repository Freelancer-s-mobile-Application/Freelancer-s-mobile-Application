// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancer_system/models/Post.dart';

class PostService {
  final CollectionReference _posts =
      FirebaseFirestore.instance.collection('Posts');

  Future<List<Post>> getAll() async {
    List<Post> posts = <Post>[];
    await _posts.get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {posts.add(Post.fromMap(doc.data() as Map<String, dynamic>))}
            }
        });
    return posts;
  }

  Future<Post> find(String id) async {
    Post post = Post();
    await _posts.doc(id).get().then(
        (value) => post = Post.fromMap(value.data() as Map<String, dynamic>));
    return post;
  }

  Future<void> add(Post post) async {
    try {
      DocumentReference ref = _posts.doc();
      post.createdDate = DateTime.now();
      post.lastModifiedDate = DateTime.now();
      post.id = ref.id;

      return await ref
          .set(post.toMap())
          .then((value) => print("Post Added"))
          .catchError((error) => print("Failed to add post: $error"));
    } on Exception catch (_) {
      throw Exception("Add exception");
    }
  }

  Future<void> delete(String id) async {
    try {
      await _posts
          .doc(id)
          .update({
            "deleted": true,
            "lastModifiedDate": DateTime.now(),
            // "updatedBy": "System"
          })
          .then((value) => print("Post deleted"))
          .catchError((error) => print("Failed to delete post: $error"));
    } on Exception catch (_) {
      throw Exception("Delete exception");
    }
  }

  Future<void> update(String id, Post post) async {
    try {
      post.lastModifiedDate = DateTime.now();
      // post.updatedBy = "";

      await _posts
          .doc(id)
          .update(post.toMap())
          .then((value) => print("Post updated"))
          .catchError((error) => print("Failed to update post: $error"));
    } on Exception catch (_) {
      throw Exception("Update exception");
    }
  }
}
