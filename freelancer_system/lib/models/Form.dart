// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ApplicationForm {
  String? userId;
  String? postId;
  String? status;
  List<String>? files;

  bool? deleted;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? lastModifiedDate;
  ApplicationForm({
    this.userId,
    this.postId,
    this.status,
    this.files,
    this.deleted,
    this.createdDate,
    this.updatedBy,
    this.lastModifiedDate,
  });

  ApplicationForm copyWith({
    String? userId,
    String? postId,
    String? status,
    List<String>? files,
    bool? deleted,
    DateTime? createdDate,
    String? updatedBy,
    DateTime? lastModifiedDate,
  }) {
    return ApplicationForm(
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      status: status ?? this.status,
      files: files ?? this.files,
      deleted: deleted ?? this.deleted,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'postId': postId,
      'status': status,
      'files': files,
      'deleted': deleted,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'updatedBy': updatedBy,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  factory ApplicationForm.fromMap(Map<String, dynamic> map) {
    return ApplicationForm(
      userId: map['userId'] != null ? map['userId'] as String : null,
      postId: map['postId'] != null ? map['postId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      files: map['files'] != null
          ? List<String>.from((map['files'] as List<String>))
          : null,
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

  factory ApplicationForm.fromJson(String source) =>
      ApplicationForm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApplicationForm(userId: $userId, postId: $postId, status: $status, files: $files, deleted: $deleted, createdDate: $createdDate, updatedBy: $updatedBy, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationForm &&
        other.userId == userId &&
        other.postId == postId &&
        other.status == status &&
        listEquals(other.files, files) &&
        other.deleted == deleted &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy &&
        other.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        postId.hashCode ^
        status.hashCode ^
        files.hashCode ^
        deleted.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode ^
        lastModifiedDate.hashCode;
  }
}
