// ignore_for_file: file_names

import 'dart:convert';

class User {
  String? username;
  String? email;
  String? address;
  String? displayname;
  String? phonenumber;
  String? description;
  String? majorId;

  User({
    this.username,
    this.email,
    this.address,
    this.displayname,
    this.phonenumber,
    this.description,
    this.majorId,
  });

  User copyWith({
    String? username,
    String? email,
    String? address,
    String? displayname,
    String? phonenumber,
    String? description,
    String? majorId,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      address: address ?? this.address,
      displayname: displayname ?? this.displayname,
      phonenumber: phonenumber ?? this.phonenumber,
      description: description ?? this.description,
      majorId: majorId ?? this.majorId,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(username: $username, email: $email, address: $address, displayname: $displayname, phonenumber: $phonenumber, description: $description, majorId: $majorId)';
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
        other.majorId == majorId;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        address.hashCode ^
        displayname.hashCode ^
        phonenumber.hashCode ^
        description.hashCode ^
        majorId.hashCode;
  }
}
