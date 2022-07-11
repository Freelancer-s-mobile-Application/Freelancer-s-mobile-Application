import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  const OptionTile(this.icon, this.option, this.color, this.func);

  final IconData icon;
  final String option;
  final Color color;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: ListTile(
          onTap: func,
          leading: Icon(
            icon,
            color: color,
          ),
          title: Text(
            option,
            style: TextStyle(color: color),
          ),
        ),
      ),
    );
  }
}
