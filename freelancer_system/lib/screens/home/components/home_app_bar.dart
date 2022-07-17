import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        "FreeLance",
        style: TextStyle(fontSize: 30, color: Colors.blue),
      ),
      bottom: const TabBar(
        labelColor: Colors.blue,
        indicatorColor: Colors.blue,
        tabs: [
          Tab(
            text: 'Look For Jobs',
          ),
          Tab(
            text: 'Hire Freelancers',
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
