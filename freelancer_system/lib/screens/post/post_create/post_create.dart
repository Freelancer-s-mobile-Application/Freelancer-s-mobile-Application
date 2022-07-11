import 'package:flutter/material.dart';
import '../../../constants/controller.dart';
import 'package:get/get.dart';

import '../../../addons/trimping.dart';
import '../../../models/Post.dart';
import '../../../services/PostService.dart';
import 'widgets/quills_text_editor.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({Key? key}) : super(key: key);

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  final _titleController = TextEditingController();
  final _rangeFixedController = TextEditingController();
  final _rangeFromController = TextEditingController();
  final _rangeToController = TextEditingController();
  final _tagController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRange = true;
  var dropValue = 'range';

  @override
  Widget build(BuildContext context) {
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
                          final ctn = trimmed(postController.postContentValue);
                          if (postController.postContentValue.isEmpty ||
                              ctn.length < 10) {
                            Get.snackbar(
                              'Error',
                              'Please enter some content',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              icon: const Icon(Icons.dangerous),
                            );
                          } else {
                            postController.post.value = Post(
                              id: 'id',
                              userId: authController.freelanceUser.value.email,
                              title: title,
                              content: postController.postContentValue,
                              min: min,
                              max: max,
                              status: 'open',
                            );
                            postController.postContent.value = '';
                            Navigator.pop(context);
                            PostService().add(postController.postValue);
                          }
                        }
                      },
                      child: const Text('Post'),
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
                if (value == null ||
                    value.isEmpty ||
                    !GetUtils.isNum(value) ||
                    int.parse(value) <= 0) {
                  return 'Invalid Field';
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
              if (value == null ||
                  value.isEmpty ||
                  !GetUtils.isNum(value) ||
                  int.parse(value) <= 0) {
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
              if (value == null ||
                  value.isEmpty ||
                  !GetUtils.isNum(value) ||
                  int.parse(value) <= 0) {
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
