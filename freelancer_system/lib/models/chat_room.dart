// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class ChatRoom {
  String roomId;
  String roomName;
  DateTime createDate;
  bool isDeleted;
  DateTime lastestMsg;
  List<String> members;
  ChatRoom({
    required this.roomId,
    required this.roomName,
    required this.createDate,
    required this.isDeleted,
    required this.lastestMsg,
    required this.members,
  });

  ChatRoom copyWith({
    String? roomId,
    String? roomName,
    DateTime? createDate,
    bool? isDeleted,
    DateTime? lastestMsg,
    List<String>? members,
  }) {
    return ChatRoom(
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      createDate: createDate ?? this.createDate,
      isDeleted: isDeleted ?? this.isDeleted,
      lastestMsg: lastestMsg ?? this.lastestMsg,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'roomName': roomName,
      'createDate': createDate,
      'isDeleted': isDeleted,
      'lastestMsg': lastestMsg,
      'members': members,
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      roomId: map['roomId'] as String,
      roomName: map['roomName'] as String,
      createDate: (map['createDate'] as Timestamp).toDate(),
      isDeleted: map['isDeleted'] as bool,
      lastestMsg: (map['lastestMsg'] as Timestamp).toDate(),
      members: List<String>.from(
        (map['members'] as List<dynamic>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRoom.fromJson(String source) =>
      ChatRoom.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatRoom(roomId: $roomId, roomName: $roomName, createDate: $createDate, isDeleted: $isDeleted, lastestMsg: $lastestMsg, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is ChatRoom &&
        other.roomId == roomId &&
        other.roomName == roomName &&
        other.createDate == createDate &&
        other.isDeleted == isDeleted &&
        other.lastestMsg == lastestMsg &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return roomId.hashCode ^
        roomName.hashCode ^
        createDate.hashCode ^
        isDeleted.hashCode ^
        lastestMsg.hashCode ^
        members.hashCode;
  }
}
