// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ApplicationForm {
  String? id;
  String? userId;
  String? postId;
  String? status;
  List<String>? files;

  bool? deleted;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? lastModifiedDate;
  ApplicationForm({
    this.id,
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
    String? id,
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
      id: id ?? this.id,
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
      'id': id,
      'userId': userId,
      'postId': postId,
      'status': status,
      'files': files,
      'deleted': deleted,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory ApplicationForm.fromMap(Map<String, dynamic> map) {
    return ApplicationForm(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      postId: map['postId'] != null ? map['postId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      files: map['files'] != null
          ? List<String>.from((map['files'] as List<String>))
          : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      createdDate: map['createdDate'] != null
          ? (map['createdDate'] as Timestamp).toDate()
          : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      lastModifiedDate: map['lastModifiedDate'] != null
          ? (map['lastModifiedDate'] as Timestamp).toDate()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationForm.fromJson(String source) =>
      ApplicationForm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApplicationForm(id: $id, userId: $userId, postId: $postId, status: $status, files: $files, deleted: $deleted, createdDate: $createdDate, updatedBy: $updatedBy, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationForm &&
        other.id == id &&
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
    return id.hashCode ^
        userId.hashCode ^
        postId.hashCode ^
        status.hashCode ^
        files.hashCode ^
        deleted.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode ^
        lastModifiedDate.hashCode;
  }
}
