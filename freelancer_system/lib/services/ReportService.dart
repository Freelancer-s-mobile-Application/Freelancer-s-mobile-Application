// ignore_for_file: file_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelancer_system/models/Report.dart';
import 'package:freelancer_system/services/UserService.dart';

class ReportService {
  final CollectionReference _reports =
      FirebaseFirestore.instance.collection('Posts');

  Future<List<Report>> getAll() async {
    List<Report> reports = <Report>[];
    try {
      await _reports.where("deleted", isEqualTo: false).get().then((value) => {
            if (value.docs.isNotEmpty)
              {
                for (var doc in value.docs)
                  {
                    reports
                        .add(Report.fromMap(doc.data() as Map<String, dynamic>))
                  }
              }
          });
    } catch (e) {
      throw Exception(e);
    }
    return reports;
  }

  Future<Report> find(String id) async {
    Report report = Report();
    await _reports.doc(id).get().then((value) =>
        report = Report.fromMap(value.data() as Map<String, dynamic>));
    return report;
  }

  Future<List<Report>> search(String? keyword) async {
    List<Report> reports = <Report>[];
    if (keyword != null) {
      await _reports
          .where("title", isGreaterThanOrEqualTo: keyword)
          .get()
          .then((value) => {
                if (value.docs.isNotEmpty)
                  {
                    for (var doc in value.docs)
                      {
                        reports.add(
                            Report.fromMap(doc.data() as Map<String, dynamic>))
                      }
                  }
              });
    } else {
      reports = await getAll();
    }

    return reports;
  }

  Future<void> add(Report report) async {
    try {
      DocumentReference ref = _reports.doc();
      report.createdDate = DateTime.now();
      report.lastModifiedDate = DateTime.now();
      report.deleted = false;
      report.updatedBy = "System";
      report.id = ref.id;

      return await ref
          .set(report.toMap())
          .then((value) => print("Report Added"))
          .catchError((error) => print("Failed to add report: $error"));
    } on Exception catch (_) {
      throw Exception("Add exception");
    }
  }

  Future<void> delete(String id) async {
    try {
      var currentUser = await UserService().getCurrentUser();

      await _reports
          .doc(id)
          .update({
            "deleted": true,
            "lastModifiedDate": DateTime.now(),
            "updatedBy": currentUser.id,
          })
          .then((value) => print("Report deleted"))
          .catchError((error) => print("Failed to delete report: $error"));
    } on Exception catch (_) {
      throw Exception("Delete exception");
    }
  }

  Future<void> update(String id, Report report) async {
    try {
      var currentUser = await UserService().getCurrentUser();

      report.lastModifiedDate = DateTime.now();
      report.updatedBy = currentUser.id;

      await _reports
          .doc(id)
          .update(report.toMap())
          .then((value) => print("Report updated"))
          .catchError((error) => print("Failed to update report: $error"));
    } on Exception catch (_) {
      throw Exception("Update exception");
    }
  }
}
