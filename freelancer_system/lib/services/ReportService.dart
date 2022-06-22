// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancer_system/models/Review.dart';
import 'package:freelancer_system/services/UserService.dart';

class ReportService {
  final CollectionReference _reviews =
      FirebaseFirestore.instance.collection('Posts');

  Future<List<Review>> getAll() async {
    List<Review> reviews = <Review>[];
    try {
      await _reviews.where("deleted", isEqualTo: false).get().then((value) => {
            if (value.docs.isNotEmpty)
              {
                for (var doc in value.docs)
                  {
                    reviews
                        .add(Review.fromMap(doc.data() as Map<String, dynamic>))
                  }
              }
          });
    } catch (e) {
      throw Exception(e);
    }
    return reviews;
  }

  Future<Review> find(String id) async {
    Review review = Review();
    await _reviews.doc(id).get().then((value) =>
        review = Review.fromMap(value.data() as Map<String, dynamic>));
    return review;
  }

  Future<List<Review>> search(String? keyword) async {
    List<Review> reviews = <Review>[];
    if (keyword != null) {
      await _reviews
          .where("title", isGreaterThanOrEqualTo: keyword)
          .get()
          .then((value) => {
                if (value.docs.isNotEmpty)
                  {
                    for (var doc in value.docs)
                      {
                        reviews.add(
                            Review.fromMap(doc.data() as Map<String, dynamic>))
                      }
                  }
              });
    } else {
      reviews = await getAll();
    }

    return reviews;
  }

  Future<void> add(Review review) async {
    try {
      DocumentReference ref = _reviews.doc();
      review.createdDate = DateTime.now();
      review.lastModifiedDate = DateTime.now();
      review.deleted = false;
      review.updatedBy = "System";
      review.id = ref.id;

      return await ref
          .set(review.toMap())
          .then((value) => print("Review Added"))
          .catchError((error) => print("Failed to add review: $error"));
    } on Exception catch (_) {
      throw Exception("Add exception");
    }
  }

  Future<void> delete(String id) async {
    try {
      var currentUser = await UserService().getCurrentUser();

      await _reviews
          .doc(id)
          .update({
            "deleted": true,
            "lastModifiedDate": DateTime.now(),
            "updatedBy": currentUser.id,
          })
          .then((value) => print("Review deleted"))
          .catchError((error) => print("Failed to delete review: $error"));
    } on Exception catch (_) {
      throw Exception("Delete exception");
    }
  }

  Future<void> update(String id, Review review) async {
    try {
      var currentUser = await UserService().getCurrentUser();

      review.lastModifiedDate = DateTime.now();
      review.updatedBy = currentUser.id;

      await _reviews
          .doc(id)
          .update(review.toMap())
          .then((value) => print("Review updated"))
          .catchError((error) => print("Failed to update review: $error"));
    } on Exception catch (_) {
      throw Exception("Update exception");
    }
  }
}
