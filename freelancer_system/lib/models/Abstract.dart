// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Abstract {
  bool? deleted;
  Timestamp? createddate;
  String? updatedBy;
  Timestamp? lastModifiedDate;

  Abstract({
    this.deleted,
    this.createddate,
    this.updatedBy,
    this.lastModifiedDate,
  });

  // Abstract copyWith({
  //   bool? deleted,
  //   Timestamp? createddate,
  //   String? updatedBy,
  //   Timestamp? lastModifiedDate,
  // }) {
  //   return Abstract(
  //     deleted: deleted ?? this.deleted,
  //     createddate: createddate ?? this.createddate,
  //     updatedBy: updatedBy ?? this.updatedBy,
  //     lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'deleted': deleted,
  //     'createddate': createddate,
  //     'updatedBy': updatedBy,
  //     'lastModifiedDate': lastModifiedDate,
  //   };
  // }

  // factory Abstract.fromMap(Map<String, dynamic> map) {
  //   return Abstract(
  //     deleted: map['deleted'] != null ? map['deleted'] as bool : null,
  //     createddate:
  //         map['createddate'] != null ? map['createddate'] as Timestamp : null,
  //     updatedBy: map['updatedBy'] != null ? map['updatedBy'] as String : null,
  //     lastModifiedDate: map['lastModifiedDate'] != null
  //         ? map['lastModifiedDate'] as Timestamp
  //         : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Abstract.fromJson(String source) =>
  //     Abstract.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'Abstract(deleted: $deleted, createddate: $createddate, updatedBy: $updatedBy, lastModifiedDate: $lastModifiedDate)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is Abstract &&
  //       other.deleted == deleted &&
  //       other.createddate == createddate &&
  //       other.updatedBy == updatedBy &&
  //       other.lastModifiedDate == lastModifiedDate;
  // }

  // @override
  // int get hashCode {
  //   return deleted.hashCode ^
  //       createddate.hashCode ^
  //       updatedBy.hashCode ^
  //       lastModifiedDate.hashCode;
  // }
}
