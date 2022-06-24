import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:freelancer_system/constants/controller.dart';
import 'package:freelancer_system/models/User.dart';
import 'package:get/get.dart';

import '../../../../services/chatService.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var addList = [].obs;
    var titleAddCtl = TextEditingController();
    return Dialog(
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(width: 2, color: Colors.white30),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    style: DefaultTextStyle.of(context).style,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search User',
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    var list =
                        userListController.getByNameAndEmail(pattern, pattern);
                    var item = list.firstWhere((element) =>
                        element.email ==
                        authController.freelanceUser.value.email);
                    list.remove(item);
                    return list;
                  },
                  itemBuilder: (context, FreeLanceUser suggestion) {
                    return ListTile(
                      leading: SizedBox(
                        width: 50,
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            child: Image.network(suggestion.avatar.toString())),
                      ),
                      title: Text(suggestion.displayname.toString()),
                      subtitle: Text(suggestion.email.toString()),
                    );
                  },
                  onSuggestionSelected: (value) {
                    if (addList.contains(value)) {
                      Get.snackbar(
                          'User already in the list', 'Please select user',
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      addList.add(value);
                    }
                  },
                ),
              ),
              Obx(() {
                if (addList.isEmpty) {
                  return const Expanded(
                      child: Center(child: Text('No User Selected')));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: addList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: SizedBox(
                            width: 50,
                            child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                                child: Image.network(
                                    addList[index].avatar.toString())),
                          ),
                          title: Text(addList[index].displayname.toString()),
                          subtitle: Text(addList[index].email.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              addList.removeAt(index);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
              ElevatedButton(
                onPressed: () async {
                  if (addList.isEmpty) {
                    Get.snackbar('Error', 'No User Selected');
                  } else {
                    List<String> users = [];
                    for (var element in addList) {
                      users.add(element.email.toString());
                    }
                    // final isExist =
                    //     await ChatService().checkDuplicateRoom(users);
                    // if (isExist) {
                    //   Get.snackbar(
                    //       snackPosition: SnackPosition.BOTTOM,
                    //       'Failed to Create Room',
                    //       'Room Already Existed');
                    // } else {
                    //   ChatService().addRoom(titleAddCtl.text, users);
                    //   Get.back();
                    //   Get.snackbar(
                    //       snackPosition: SnackPosition.BOTTOM,
                    //       'Success',
                    //       'Room Added');
                    // }
                    ChatService().addRoom(titleAddCtl.text, users);
                    Get.back();
                    Get.snackbar(
                        snackPosition: SnackPosition.BOTTOM,
                        'Success',
                        'Room Added');
                  }
                },
                child: const Text('Create Room'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
