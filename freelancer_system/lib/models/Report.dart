// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String? id;
  String? comment;
  String? receiverId;
  String? reporterId;

  bool? deleted;
  DateTime? lastModifiedDate;
  DateTime? createdDate;
  String? updatedBy;
  Report({
    this.id,
    this.comment,
    this.receiverId,
    this.reporterId,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  Report copyWith({
    String? id,
    String? comment,
    String? receiverId,
    String? reporterId,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
    String? updatedBy,
  }) {
    return Report(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      receiverId: receiverId ?? this.receiverId,
      reporterId: reporterId ?? this.reporterId,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comment': comment,
      'receiverId': receiverId,
      'reporterId': reporterId,
      'deleted': deleted,
      'lastModifiedDate': lastModifiedDate,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'] != null ? map['id'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      reporterId:
          map['reporterId'] != null ? map['reporterId'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      lastModifiedDate: (map['lastModifiedDate'] as Timestamp).toDate(),
      createdDate: (map['createdDate'] as Timestamp).toDate(),
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) =>
      Report.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Report(id: $id, comment: $comment, receiverId: $receiverId, reporterId: $reporterId, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Report &&
        other.id == id &&
        other.comment == comment &&
        other.receiverId == receiverId &&
        other.reporterId == reporterId &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        comment.hashCode ^
        receiverId.hashCode ^
        reporterId.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
