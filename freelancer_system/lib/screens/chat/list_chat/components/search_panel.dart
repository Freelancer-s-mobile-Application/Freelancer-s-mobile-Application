import 'package:flutter/material.dart';
import 'package:freelancer_system/services/chatService.dart';
import 'package:get/get.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userAddCtl = TextEditingController();
    var titleAddCtl = TextEditingController();
    return Dialog(
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2, color: Colors.white30),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'User',
                  ),
                  controller: userAddCtl,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                  controller: titleAddCtl,
                ),
              ),
              IconButton(
                  color: Colors.red,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ChatService().addRoom(titleAddCtl.text, userAddCtl.text);
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
