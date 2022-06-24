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
        future: userService.getAll(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].email.toString()),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    // Here We Will Add The Delete Feature
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // debugPrint();
          await postService
              .add(Post(
                  userId: "1",
                  title: 'Test2',
                  content: 'Test2',
                  min: 1,
                  max: 3,
                  status: "open"))
              .catchError((error) {
            debugPrint(error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
