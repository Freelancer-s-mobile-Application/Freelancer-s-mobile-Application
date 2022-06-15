// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? senderId;
  String? receiverId;
  String? content;
  bool? isSeen;

  bool? deleted;
  Timestamp? lastModifiedDate;
  Timestamp? createdDate;
  String? updatedBy;
  Message({
    this.senderId,
    this.receiverId,
    this.content,
    this.isSeen,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  Message copyWith({
    String? senderId,
    String? receiverId,
    String? content,
    bool? isSeen,
    bool? deleted,
    Timestamp? lastModifiedDate,
    Timestamp? createdDate,
    String? updatedBy,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      isSeen: isSeen ?? this.isSeen,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'isSeen': isSeen,
      'deleted': deleted,
      'lastModifiedDate': lastModifiedDate,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      isSeen: map['isSeen'] != null ? map['isSeen'] as bool : null,
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

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(senderId: $senderId, receiverId: $receiverId, content: $content, isSeen: $isSeen, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.content == content &&
        other.isSeen == isSeen &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        receiverId.hashCode ^
        content.hashCode ^
        isSeen.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
