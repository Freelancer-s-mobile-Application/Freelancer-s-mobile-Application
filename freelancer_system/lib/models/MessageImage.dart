// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageImage {
  String? id;
  String? messageId;
  String? url;
  bool? deleted;
  DateTime? lastModifiedDate;
  DateTime? createdDate;
  String? updatedBy;
  MessageImage({
    this.id,
    this.messageId,
    this.url,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  MessageImage copyWith({
    String? id,
    String? messageId,
    String? url,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
    String? updatedBy,
  }) {
    return MessageImage(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      url: url ?? this.url,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'messageId': messageId,
      'url': url,
      'deleted': deleted,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory MessageImage.fromMap(Map<String, dynamic> map) {
    return MessageImage(
      id: map['id'] != null ? map['id'] as String : null,
      messageId: map['messageId'] != null ? map['messageId'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
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

  factory MessageImage.fromJson(String source) =>
      MessageImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageImage(id: $id, messageId: $messageId, url: $url, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageImage &&
        other.id == id &&
        other.messageId == messageId &&
        other.url == url &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        messageId.hashCode ^
        url.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
