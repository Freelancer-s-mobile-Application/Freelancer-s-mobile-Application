// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Major {
  String? id;
  String? name;

  bool? deleted;
  DateTime? lastModifiedDate;
  DateTime? createdDate;
  String? updatedBy;
  Major({
    this.id,
    this.name,
    this.deleted,
    this.lastModifiedDate,
    this.createdDate,
    this.updatedBy,
  });

  Major copyWith({
    String? id,
    String? name,
    bool? deleted,
    DateTime? lastModifiedDate,
    DateTime? createdDate,
    String? updatedBy,
  }) {
    return Major(
      id: id ?? this.id,
      name: name ?? this.name,
      deleted: deleted ?? this.deleted,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      createdDate: createdDate ?? this.createdDate,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'deleted': deleted,
      'lastModifiedDate': lastModifiedDate,
      'createdDate': createdDate,
      'updatedBy': updatedBy,
    };
  }

  factory Major.fromMap(Map<String, dynamic> map) {
    return Major(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      deleted: map['deleted'] != null ? map['deleted'] as bool : null,
      lastModifiedDate: (map['lastModifiedDate'] as Timestamp).toDate(),
      createdDate: (map['createdDate'] as Timestamp).toDate(),
      updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Major.fromJson(String source) =>
      Major.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Major(id: $id, name: $name, deleted: $deleted, lastModifiedDate: $lastModifiedDate, createdDate: $createdDate, updatedBy: $updatedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Major &&
        other.id == id &&
        other.name == name &&
        other.deleted == deleted &&
        other.lastModifiedDate == lastModifiedDate &&
        other.createdDate == createdDate &&
        other.updatedBy == updatedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        deleted.hashCode ^
        lastModifiedDate.hashCode ^
        createdDate.hashCode ^
        updatedBy.hashCode;
  }
}
