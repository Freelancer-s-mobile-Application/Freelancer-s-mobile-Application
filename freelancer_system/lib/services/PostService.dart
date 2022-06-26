// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancer_system/models/Post.dart';
import 'package:freelancer_system/services/UserService.dart';

class PostService {
  final CollectionReference _posts =
      FirebaseFirestore.instance.collection('Posts');

  Future<List<Post>> getAll() async {
    List<Post> posts = <Post>[];
    await _posts.where("deleted", isEqualTo: false).get().then((value) => {
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

  Future<List<Post>> search(String? keyword) async {
    List<Post> posts = <Post>[];
    if (keyword != null) {
      await _posts
          .where("title", isGreaterThanOrEqualTo: keyword)
          .get()
          .then((value) => {
                if (value.docs.isNotEmpty)
                  {
                    for (var doc in value.docs)
                      {
                        posts.add(
                            Post.fromMap(doc.data() as Map<String, dynamic>))
                      }
                  }
              });
    } else {
      posts = await getAll();
    }

    return posts;
  }

  Future<void> add(Post post) async {
    try {
      DocumentReference ref = _posts.doc();
      post.createdDate = DateTime.now();
      post.lastModifiedDate = DateTime.now();
      post.deleted = false;
      post.updatedBy = "System";
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
      var currentUser = await UserService().getCurrentUser();

      await _posts
          .doc(id)
          .update({
            "deleted": true,
            "lastModifiedDate": DateTime.now(),
            "updatedBy": currentUser.id,
          })
          .then((value) => print("Post deleted"))
          .catchError((error) => print("Failed to delete post: $error"));
    } on Exception catch (_) {
      throw Exception("Delete exception");
    }
  }

  Future<void> update(String id, Post post) async {
    try {
      var currentUser = await UserService().getCurrentUser();

      post.lastModifiedDate = DateTime.now();
      post.updatedBy = currentUser.id;

      await _posts
          .doc(id)
          .update(post.toMap())
          .then((value) => print("Post updated"))
          .catchError((error) => print("Failed to update post: $error"));
    } on Exception catch (_) {
      throw Exception("Update exception");
    }
  }

  Stream<List<Post>> postStream() {
    return _posts
        .where("deleted", isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final f = Post.fromMap(doc.data() as dynamic);
              return f;
            }).toList());
  }
}
