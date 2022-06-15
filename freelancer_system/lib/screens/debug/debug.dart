import 'package:flutter/material.dart';

import '../../services/user_service.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          debugPrint(await userService.getFirstUser());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
