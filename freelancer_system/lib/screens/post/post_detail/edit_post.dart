import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/controller.dart';
import '../../../models/Post.dart';
import '../../../services/PostService.dart';
import '../post_create/widgets/quills_text_editor.dart';

class EditPost extends StatefulWidget {
  const EditPost(this.post);

  final Post post;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _titleController = TextEditingController();
  final _rangeFixedController = TextEditingController();
  final _rangeFromController = TextEditingController();
  final _rangeToController = TextEditingController();
  final _tagController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRange = true;
  var dropValue = 'range';

  Post curPost = Post();

  @override
  void initState() {
    super.initState();
    curPost = widget.post;
    if (int.parse(widget.post.min!.toString()) <
        int.parse(widget.post.max!.toString())) {
      isRange = true;
    } else {
      isRange = false;
      dropValue = 'fixed';
    }
    String t = widget.post.title.toString().split('] ')[1];
    _titleController.text = t;
    _rangeFixedController.text = widget.post.min!.toString();
    _rangeFromController.text = widget.post.min!.toString();
    _rangeToController.text =
        isRange ? widget.post.max!.toString() : 0.toString();
    _tagController.text = getTag(widget.post.title!);
    postController.postContent.value = widget.post.content!;
  }

  String getTag(String str) {
    String data = str.split('[')[1];
    data = data.split(']')[0];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var post = widget.post;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Title';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(
                    items: const [
                      DropdownMenuItem(value: 'range', child: Text('Range')),
                      DropdownMenuItem(value: 'fixed', child: Text('Fixed')),
                    ],
                    value: dropValue,
                    onChanged: (v) {
                      setState(() {
                        dropValue = v.toString();
                        isRange = v == 'range';
                      });
                    },
                  ),
                  ...range()
                ],
              ),
            ),
            TextFormField(
              controller: _tagController,
              decoration: const InputDecoration(
                labelText: 'Tag',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some Job Tag';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(
                            QuillsTextEditor(postController.postContentValue));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Content Editor'),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String title =
                              '[${_tagController.text}] ${_titleController.text}';
                          int min = 0;
                          int max = 0;
                          if (isRange) {
                            min = int.parse(_rangeFromController.text);
                            max = int.parse(_rangeToController.text);
                          } else {
                            min = int.parse(_rangeFixedController.text);
                            max = min;
                          }
                          if (postController.postContentValue.isEmpty) {
                            Get.snackbar(
                              'Error',
                              'Please enter some content',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              icon: const Icon(Icons.dangerous),
                            );
                          } else {
                            postController.post.value = Post(
                              id: post.id,
                              userId: authController.freelanceUser.value.email,
                              title: title,
                              content: postController.postContentValue,
                              min: min,
                              max: max,
                              deleted: post.deleted,
                              createdDate: post.createdDate,
                              lastModifiedDate: post.lastModifiedDate,
                              updatedBy:
                                  authController.freelanceUser.value.email,
                              status: 'open',
                            );
                            if (curPost == postController.post.value) {
                              Get.snackbar('Not thing Changed', '',
                                  backgroundColor: Colors.blue,
                                  colorText: Colors.white);
                            } else {
                              postController.post.value.copyWith(
                                updatedBy:
                                    authController.freelanceUser.value.email,
                                createdDate: post.createdDate,
                                lastModifiedDate: DateTime.now(),
                              );
                              PostService().update(
                                  post.id.toString(), postController.postValue);
                              Get.back();
                              Get.back();
                              Get.snackbar('Post Updated', '',
                                  backgroundColor: Colors.blue,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          }
                        }
                      },
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> range() {
    if (!isRange) {
      return [
        SizedBox(
          width: Get.width * 0.2,
          child: Center(
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty || !GetUtils.isNum(value)) {
                  return 'Empty Field';
                }
                return null;
              },
              textAlign: TextAlign.center,
              controller: _rangeFixedController,
              decoration: const InputDecoration(
                hintText: '0',
              ),
            ),
          ),
        ),
        const Text('People'),
      ];
    } else {
      return [
        SizedBox(
          width: Get.width * 0.2,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty || !GetUtils.isNum(value)) {
                Get.snackbar(
                    'Invalid Input', 'Empty Field or Field not a number',
                    backgroundColor: Colors.red,
                    icon: const Icon(Icons.dangerous),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.TOP);
                return 'Empty Field';
              }
              if ((int.parse(_rangeToController.text) -
                      int.parse(_rangeFromController.text)) <=
                  0) {
                Get.snackbar('Invalid Input', 'Hire Range not correct',
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.TOP);
                return 'Invalid';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: _rangeFromController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: '0',
            ),
          ),
        ),
        const Text('To'),
        SizedBox(
          width: Get.width * 0.2,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty || !GetUtils.isNum(value)) {
                Get.snackbar(
                    'Invalid Input', 'Empty Field or Field not a number',
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.TOP);
                return 'Empty Field';
              }
              if ((int.parse(_rangeToController.text) -
                      int.parse(_rangeFromController.text)) <=
                  0) {
                Get.snackbar('Invalid Input', 'Hire Range not correct',
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.TOP);
                return 'Invalid';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            controller: _rangeToController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: '0',
            ),
          ),
        ),
        const Text('People'),
      ];
    }
  }
}
