// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:freelancer_system/models/Abstract.dart';

class User extends Abstract {
  String? username;
  String? email;
  String? address;
  String? displayname;
  String? phonenumber;
  String? description;
  String? majorId;

  // bool? deleted;
  // Timestamp? createddate;
  // String? updatedBy;
  // Timestamp? lastModifiedDate;
  User({
    this.username,
    this.email,
    this.address,
    this.displayname,
    this.phonenumber,
    this.description,
    this.majorId,
    // this.deleted,
    // this.createddate,
    // this.updatedBy,
    // this.lastModifiedDate,
  }) : super();

  User copyWith({
    String? username,
    String? email,
    String? address,
    String? displayname,
    String? phonenumber,
    String? description,
    String? majorId,
    bool? deleted,
    Timestamp? createddate,
    String? updatedBy,
    Timestamp? lastModifiedDate,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      displayname: displayname ?? this.displayname,
      phonenumber: phonenumber ?? this.phonenumber,
      description: description ?? this.description,
      majorId: majorId ?? this.majorId,
      // deleted: deleted ?? this.deleted,
      // createddate: createddate ?? this.createddate,
      // updatedBy: updatedBy ?? this.updatedBy,
      // lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'address': address,
      'displayname': displayname,
      'phonenumber': phonenumber,
      'description': description,
      'majorId': majorId,
      'deleted': deleted,
      'createddate': createddate,
      'updatedBy': updatedBy,
      'lastModifiedDate': lastModifiedDate,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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
      // deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      // createddate:
      //     map['createddate'] != null ? map['createddate'] as Timestamp : null,
      // updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
      // lastModifiedDate: map['lastModifiedDate'] != null
      //     ? map['lastModifiedDate'] as Timestamp
      //     : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(username: $username, email: $email, address: $address, displayname: $displayname, phonenumber: $phonenumber, description: $description, majorId: $majorId, deleted: $deleted, createddate: $createddate, updatedBy: $updatedBy, lastModifiedDate: $lastModifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.username == username &&
        other.email == email &&
        other.address == address &&
        other.displayname == displayname &&
        other.phonenumber == phonenumber &&
        other.description == description &&
        other.majorId == majorId &&
        other.deleted == deleted &&
        other.createddate == createddate &&
        other.updatedBy == updatedBy &&
        other.lastModifiedDate == lastModifiedDate;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        address.hashCode ^
        displayname.hashCode ^
        phonenumber.hashCode ^
        description.hashCode ^
        majorId.hashCode ^
        deleted.hashCode ^
        createddate.hashCode ^
        updatedBy.hashCode ^
        lastModifiedDate.hashCode;
  }
}
