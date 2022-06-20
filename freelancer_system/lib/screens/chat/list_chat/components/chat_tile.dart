import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Column(
          children: [
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: const Center(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: FlutterLogo(size: 50),
                    title: Text('Chat'),
                    subtitle: Text('Chat'),
                    trailing: Icon(Icons.chat),
                  ),
                ),
              ),
            ),
            const Divider()
          ],
        );
      },
    );
  }
}
