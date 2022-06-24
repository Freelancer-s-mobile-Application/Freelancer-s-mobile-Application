// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? userId;
  String? title;
  String? content;
  num? min;
  num? max;
  String? status;

  bool? deleted;
  DateTime? lastModifiedDate;
  DateTime? createdDate;
  String? updatedBy;
  Post({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.min,
    this.max,
    this.status,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  Post copyWith({
    String? id,
    String? userId,
    String? title,
    String? content,
    num? min,
    num? max,
    String? status,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
    String? updatedBy,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      min: min ?? this.min,
      max: max ?? this.max,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'min': min,
      'max': max,
      'status': status,
      'deleted': deleted,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
      'lastModifiedDate': createdDate,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      min: map['min'] != null ? map['min'] as num : null,
      max: map['max'] != null ? map['max'] as num : null,
      status: map['status'] != null ? map['status'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      lastModifiedDate: map['lastModifiedDate'] != null
          ? (map['lastModifiedDate'] as Timestamp).toDate()
          : null,
      createdDate: map['createdDate'] != null
          ? (map['createdDate'] as Timestamp).toDate()
          : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, title: $title, content: $content, min: $min, max: $max, status: $status, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.content == content &&
        other.min == min &&
        other.max == max &&
        other.status == status &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        content.hashCode ^
        min.hashCode ^
        max.hashCode ^
        status.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
