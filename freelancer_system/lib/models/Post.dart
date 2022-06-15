// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? userId;
  String? title;
  String? content;
  num? minNumber;
  num? maxNumber;
  String? status;

  bool? deleted;
  Timestamp? lastModifiedDate;
  Timestamp? createdDate;
  String? updatedBy;

  Post({
    this.userId,
    this.title,
    this.content,
    this.minNumber,
    this.maxNumber,
    this.status,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  Post copyWith({
    String? userId,
    String? title,
    String? content,
    num? minNumber,
    num? maxNumber,
    String? status,
    bool? deleted,
    Timestamp? lastModifiedDate,
    Timestamp? createdDate,
    String? updatedBy,
  }) {
    return Post(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      minNumber: minNumber ?? this.minNumber,
      maxNumber: maxNumber ?? this.maxNumber,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'title': title,
      'content': content,
      'minNumber': minNumber,
      'maxNumber': maxNumber,
      'status': status,
      'deleted': deleted,
      'lastModifiedDate': lastModifiedDate,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] != null ? map['userId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      minNumber: map['minNumber'] != null ? map['minNumber'] as num : null,
      maxNumber: map['maxNumber'] != null ? map['maxNumber'] as num : null,
      status: map['status'] != null ? map['status'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      createdDate:
          map['createddate'] != null ? map['createddate'] as Timestamp : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      lastModifiedDate: map['lastModifiedDate'] != null
          ? map['lastModifiedDate'] as Timestamp
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(userId: $userId, title: $title, content: $content, minNumber: $minNumber, maxNumber: $maxNumber, status: $status, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.userId == userId &&
        other.title == title &&
        other.content == content &&
        other.minNumber == minNumber &&
        other.maxNumber == maxNumber &&
        other.status == status &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        title.hashCode ^
        content.hashCode ^
        minNumber.hashCode ^
        maxNumber.hashCode ^
        status.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
