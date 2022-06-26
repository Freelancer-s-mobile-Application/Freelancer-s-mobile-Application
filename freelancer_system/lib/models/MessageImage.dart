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

  MessageImage({
    this.id,
    this.messageId,
    this.url,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
  });

  MessageImage copyWith({
    String? id,
    String? messageId,
    String? url,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
  }) {
    return MessageImage(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      url: url ?? this.url,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'messageId': messageId,
      'url': url,
      'deleted': deleted,
      'lastModifiedDate': lastModifiedDate,
      'createdDate': createdDate,
    };
  }

  factory MessageImage.fromMap(Map<String, dynamic> map) {
    return MessageImage(
      id: map['id'] != null ? map['id'] as String : null,
      messageId: map['messageId'] != null ? map['messageId'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      lastModifiedDate: (map['lastModifiedDate'] as Timestamp).toDate(),
      createdDate: (map['createdDate'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageImage.fromJson(String source) =>
      MessageImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageImage(id: $id, messageId: $messageId, url: $url, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate)';
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
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        messageId.hashCode ^
        url.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode;
  }
}
