// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String? commentId;
  String? content;
  String? postId;
  String? userId;

  bool? deleted;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? lastModifiedDate;
  Comment({
    this.commentId,
    this.content,
    this.postId,
    this.userId,
    this.deleted,
    this.createdDate,
    this.updatedBy,
    this.lastModifiedDate,
  });

  Comment copyWith({
    String? commentId,
    String? content,
    String? postId,
    String? userId,
    bool? deleted,
    DateTime? createdDate,
    String? updatedBy,
    DateTime? lastModifiedDate,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      content: content ?? this.content,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      deleted: deleted ?? this.deleted,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'content': content,
      'postId': postId,
      'userId': userId,
      'deleted': deleted,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'updatedBy': updatedBy,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentId: map['commentId'] != null ? map['commentId'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      postId: map['postId'] != null ? map['postId'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      createdDate: map['createdDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int)
          : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      lastModifiedDate: map['lastModifiedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(commentId: $commentId, content: $content, postId: $postId, userId: $userId, deleted: $deleted, createdDate: $createdDate, updatedBy: $updatedBy, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.commentId == commentId &&
        other.content == content &&
        other.postId == postId &&
        other.userId == userId &&
        other.deleted == deleted &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy &&
        other.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
        content.hashCode ^
        postId.hashCode ^
        userId.hashCode ^
        deleted.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode ^
        lastModifiedDate.hashCode;
  }
}
