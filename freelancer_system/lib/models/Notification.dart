// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String? id;
  String? senderId;
  String? receiverId;
  String? title;
  String? content;
  bool? isSeen;

  bool? deleted;
  DateTime? lastModifiedDate;
  DateTime? createdDate;
  String? updatedBy;
  Notification({
    this.id,
    this.senderId,
    this.receiverId,
    this.title,
    this.content,
    this.isSeen,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  Notification copyWith({
    String? id,
    String? senderId,
    String? receiverId,
    String? title,
    String? content,
    bool? isSeen,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
    String? updatedBy,
  }) {
    return Notification(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      title: title ?? this.title,
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
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'title': title,
      'content': content,
      'isSeen': isSeen,
      'deleted': deleted,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'] != null ? map['id'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      isSeen: map['isSeen'] != null ? map['isSeen'] as bool : null,
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

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Notification(id: $id, senderId: $senderId, receiverId: $receiverId, title: $title, content: $content, isSeen: $isSeen, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Notification &&
        other.id == id &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.title == title &&
        other.content == content &&
        other.isSeen == isSeen &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderId.hashCode ^
        receiverId.hashCode ^
        title.hashCode ^
        content.hashCode ^
        isSeen.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
