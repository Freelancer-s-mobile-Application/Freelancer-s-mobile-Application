import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_system/models/Post.dart';
import 'package:freelancer_system/models/User.dart';
import 'package:freelancer_system/services/FormService.dart';
import 'package:freelancer_system/services/PostService.dart';

import '../../services/UserService.dart';

void debug() {
  runApp(const DebugScreen());
}

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DebugPage(),
    );
  }
}

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);
  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  final UserService userService = UserService();
  final FormService formService = FormService();
  final PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: userService.getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(snapshot.data.avatar.toString()),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    debugPrint(snapshot.data.avatar.toString());
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var currentUser = await userService.getCurrentUser();
          await userService.add(currentUser).catchError((error) {
            debugPrint(error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
