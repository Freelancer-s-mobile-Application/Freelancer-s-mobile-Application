// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? username;
  String? email;
  String? address;
  String? displayname;
  String? phonenumber;
  String? description;
  String? majorId;

  bool? deleted;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? lastModifiedDate;
  User({
    this.id,
    this.username,
    this.email,
    this.address,
    this.displayname,
    this.phonenumber,
    this.description,
    this.majorId,
    this.deleted,
    this.createdDate,
    this.updatedBy,
    this.lastModifiedDate,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? address,
    String? displayname,
    String? phonenumber,
    String? description,
    String? majorId,
    bool? deleted,
    DateTime? createdDate,
    String? updatedBy,
    DateTime? lastModifiedDate,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      displayname: displayname ?? this.displayname,
      phonenumber: phonenumber ?? this.phonenumber,
      description: description ?? this.description,
      majorId: majorId ?? this.majorId,
      deleted: deleted ?? this.deleted,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'address': address,
      'displayname': displayname,
      'phonenumber': phonenumber,
      'description': description,
      'majorId': majorId,
      'deleted': deleted,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'updatedBy': updatedBy,
      'lastModifiedDate': lastModifiedDate?.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      displayname:
          map['displayname'] != null ? map['displayname'] as String : null,
      phonenumber:
          map['phonenumber'] != null ? map['phonenumber'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      majorId: map['majorId'] != null ? map['majorId'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      createdDate: map['createdDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int)
          : null,
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      lastModifiedDate: map['lastModifiedDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastModifiedDate'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, address: $address, displayname: $displayname, phonenumber: $phonenumber, description: $description, majorId: $majorId, deleted: $deleted, createdDate: $createdDate, updatedBy: $updatedBy, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.username == username &&
        other.email == email &&
        other.address == address &&
        other.displayname == displayname &&
        other.phonenumber == phonenumber &&
        other.description == description &&
        other.majorId == majorId &&
        other.deleted == deleted &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy &&
        other.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        address.hashCode ^
        displayname.hashCode ^
        phonenumber.hashCode ^
        description.hashCode ^
        majorId.hashCode ^
        deleted.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode ^
        lastModifiedDate.hashCode;
  }
}
