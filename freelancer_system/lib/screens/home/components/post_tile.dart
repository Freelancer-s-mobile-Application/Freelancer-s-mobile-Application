import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/Post.dart';
import '../../post/post_detail/post_screen.dart';

class PostTile extends StatelessWidget {
  const PostTile({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => PostScreen(post));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PhysicalModel(
          color: Colors.black,
          shadowColor: Colors.blue.shade200,
          shape: BoxShape.circle,
          elevation: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          post.content.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //TODO Go to Requirement filter
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(post.status.toString()),
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.user,
                          size: 13,
                        ),
                        Text("${post.min} - ${post.max}")
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text('Apply')),
                    Text(DateFormat('dd/MM/yyyy').format(post.createdDate!)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
