import 'package:flutter/material.dart';
import 'package:freelancer_system/services/form_service.dart';

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
  final FormService formService = FormService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // debugPrint();
          await formService
              .findByUserId("4m4gw4I4EFg3MbxxdMFs")
              .then((value) => value.forEach((element) {
                    formService.add(element);
                  }))
              .catchError((error) {
            debugPrint(error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
