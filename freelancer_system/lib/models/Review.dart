// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String? id;
  String? comment;
  String? receiverId;
  String? senderId;
  num? ratingPoint;

  bool? deleted;
  DateTime? lastModifiedDate;
  DateTime? createdDate;
  String? updatedBy;
  Review({
    this.id,
    this.comment,
    this.receiverId,
    this.senderId,
    this.ratingPoint,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  Review copyWith({
    String? id,
    String? comment,
    String? receiverId,
    String? senderId,
    num? ratingPoint,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
    String? updatedBy,
  }) {
    return Review(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      ratingPoint: ratingPoint ?? this.ratingPoint,
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
      'senderId': senderId,
      'ratingPoint': ratingPoint,
      'deleted': deleted,
      'lastModifiedDate': lastModifiedDate,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] != null ? map['id'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      ratingPoint:
          map['ratingPoint'] != null ? map['ratingPoint'] as num : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      lastModifiedDate: (map['lastModifiedDate'] as Timestamp).toDate(),
      createdDate: (map['createdDate'] as Timestamp).toDate(),
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Review(id: $id, comment: $comment, receiverId: $receiverId, senderId: $senderId, ratingPoint: $ratingPoint, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Review &&
        other.id == id &&
        other.comment == comment &&
        other.receiverId == receiverId &&
        other.senderId == senderId &&
        other.ratingPoint == ratingPoint &&
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
        senderId.hashCode ^
        ratingPoint.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
