import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';

class UserLoggedInIcon extends StatelessWidget {
  const UserLoggedInIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
          onPressed: () {
            Size size = MediaQuery.of(context).size;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: SizedBox(
                  height: size.height * 0.6,
                  width: size.width * 0.9,
                  child: const LoginScreen(),
                ),
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.user,
            color: Colors.blue,
          )),
    );
  }
}
