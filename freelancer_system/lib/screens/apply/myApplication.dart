import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/models/Form.dart';

import '../../services/FormService.dart';
import 'widgets/form_tile.dart';

class MyApplicationsScreen extends StatelessWidget {
  const MyApplicationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FormService().getStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Applications'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final ApplicationForm data = ApplicationForm.fromMap(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>);
                return FormTile(data);
              },
            );
          }
        },
      ),
    );
  }
}
