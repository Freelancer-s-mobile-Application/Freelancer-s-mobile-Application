// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Form {
  String? userId;
  String? postId;
  String? status;
  List<String>? files;

  Form({
    this.userId,
    this.postId,
    this.status,
    this.files,
  });

  Form copyWith({
    String? userId,
    String? postId,
    String? status,
    List<String>? files,
  }) {
    return Form(
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      status: status ?? this.status,
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'postId': postId,
      'status': status,
      'files': files,
    };
  }

  factory Form.fromMap(Map<String, dynamic> map) {
    return Form(
      userId: map['userId'] != null ? map['userId'] as String : null,
      postId: map['postId'] != null ? map['postId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      files: map['files'] != null
          ? List<String>.from((map['files'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Form.fromJson(String source) =>
      Form.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Form(userId: $userId, postId: $postId, status: $status, files: $files)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Form &&
        other.userId == userId &&
        other.postId == postId &&
        other.status == status &&
        listEquals(other.files, files);
  }

  @override
  int get hashCode {
    return userId.hashCode ^ postId.hashCode ^ status.hashCode ^ files.hashCode;
  }
}
