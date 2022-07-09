import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../constants/controller.dart';
import '../../../../helpers/loading.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../../../../helpers/image_pic.dart';
import '../../../../services/chatService.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  String img = '';
  RxList addList = [].obs;
  var titleAddCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              if (img.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(img),
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
                    List<types.User> list =
                        userListController.getByNameAndEmail(pattern, pattern);
                    var set1 = Set.from(list);
                    var set2 = Set.from(addList);
                    list = List.from(set1.difference(set2));
                    return list;
                  },
                  itemBuilder: (context, types.User suggestion) {
                    return ListTile(
                      leading: SizedBox(
                        width: 50,
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            child:
                                Image.network(suggestion.imageUrl.toString())),
                      ),
                      title: Text(suggestion.firstName.toString()),
                      subtitle: Text(suggestion.id.toString()),
                    );
                  },
                  onSuggestionSelected: (types.User value) {
                    addList.add(value);
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
                                    addList[index].imageUrl.toString())),
                          ),
                          title: Text(addList[index].firstName.toString()),
                          subtitle: Text(addList[index].id.toString()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: Get.height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          primary: Colors.deepOrangeAccent.shade400),
                      onPressed: () async {
                        showLoading();
                        img = await selectRoomImage();
                        dissmissLoading();
                        setState(() {});
                      },
                      child: const Text('Select Room Image \n(Optional)'),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (addList.isEmpty) {
                          Get.snackbar('Error', 'No User Selected');
                        } else {
                          List<types.User> users = [];
                          for (var element in addList) {
                            users.add(element);
                          }
                          ChatService()
                              .createRoom(users, titleAddCtl.text, img);
                          Get.back();
                          Get.snackbar(
                              snackPosition: SnackPosition.BOTTOM,
                              'Success',
                              'Room Added');
                        }
                      },
                      child: const Text('Create Room'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
