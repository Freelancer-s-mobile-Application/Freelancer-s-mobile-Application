import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.black,
      leading: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: const Icon(Icons.flutter_dash, size: 50),
      ),
      title: const Text('Lung N, @hung123'),
      subtitle: RichText(
        text: const TextSpan(
          style: TextStyle(letterSpacing: 1),
          children: [
            WidgetSpan(
              child: Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ),
            TextSpan(text: ' 5.0', style: TextStyle(color: Colors.black)),
            WidgetSpan(child: SizedBox(width: 20)),
            WidgetSpan(
              child: Icon(
                Icons.location_city,
                color: Colors.blue,
              ),
            ),
            TextSpan(text: ' HCM City', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      trailing: GestureDetector(
        onTap: () {},
        child: const Icon(
          Icons.star,
          color: Colors.red,
        ),
      ),
    );
  }
}
