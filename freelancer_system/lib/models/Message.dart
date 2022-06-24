// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class FreeLanceMessage {
  String senderId;
  String content;
  DateTime createdDate;
  List<String> seenBy;
  bool isDeleted;
  String updatedBy;
  DateTime lastModifiedDate;

  FreeLanceMessage({
    required this.senderId,
    required this.content,
    required this.createdDate,
    required this.seenBy,
    required this.isDeleted,
    required this.updatedBy,
    required this.lastModifiedDate,

  });

  FreeLanceMessage copyWith({
    String? senderId,
    String? content,
    DateTime? createdDate,
    List<String>? seenBy,
    bool? isDeleted,
    String? updatedBy,
    DateTime? lastModifiedDate,
  }) {
    return FreeLanceMessage(
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      createdDate: createdDate ?? this.createdDate,
      seenBy: seenBy ?? this.seenBy,
      isDeleted: isDeleted ?? this.isDeleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      updatedBy: updatedBy ?? this.updatedBy,

    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'content': content,
      'createdDate': createdDate,
      'seenBy': seenBy,
      'isDeleted': isDeleted,
      'lastModifiedDate': lastModifiedDate,
      'updatedBy': updatedBy

    };
  }

  factory FreeLanceMessage.fromMap(Map<String, dynamic> map) {
    return FreeLanceMessage(
      senderId: map['senderId'] as String,
      content: map['content'] as String,
      createdDate: (map['createdDate'] as Timestamp).toDate(),
      seenBy: List<String>.from((map['seenBy'] as List<dynamic>)),
      isDeleted: map['isDeleted'] as bool,
      lastModifiedDate: (map['lastModifiedDate'] as Timestamp).toDate(),
      updatedBy: map['updatedBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FreeLanceMessage.fromJson(String source) =>
      FreeLanceMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FreeLanceMessage(senderId: $senderId, content: $content, createdDate: $createdDate, seenBy: $seenBy, isDeleted: $isDeleted, updatedBy: $updatedBy, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is FreeLanceMessage &&
        other.senderId == senderId &&
        other.content == content &&
        other.createdDate == createdDate &&
        listEquals(other.seenBy, seenBy) &&
        other.isDeleted == isDeleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        content.hashCode ^
        createdDate.hashCode ^
        seenBy.hashCode ^
        isDeleted.hashCode ^
        lastModifiedDate.hashCode ^
        updatedBy.hashCode;
  }
}
