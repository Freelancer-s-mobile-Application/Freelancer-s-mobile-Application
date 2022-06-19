// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostContent {
  String? postId;
  String? url;
  String? type;

  bool? deleted;
  DateTime? lastModifiedDate;
  DateTime? createdDate;
  String? updatedBy;
  PostContent({
    this.postId,
    this.url,
    this.type,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  PostContent copyWith({
    String? postId,
    String? url,
    String? type,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
    String? updatedBy,
  }) {
    return PostContent(
      postId: postId ?? this.postId,
      url: url ?? this.url,
      type: type ?? this.type,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'url': url,
      'type': type,
      'deleted': deleted,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'updatedBy': updatedBy,
    };
  }

  factory PostContent.fromMap(Map<String, dynamic> map) {
    return PostContent(
      postId: map['postId'] != null ? map['postId'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      createdDate: map['createdDate'] != null
          ? map['createdDate'].toDate() as DateTime
          : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      lastModifiedDate: map['lastModifiedDate'] != null
          ? map['lastModifiedDate'].toDate() as DateTime
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostContent.fromJson(String source) =>
      PostContent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostContent(postId: $postId, url: $url, type: $type, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostContent &&
        other.postId == postId &&
        other.url == url &&
        other.type == type &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        url.hashCode ^
        type.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
