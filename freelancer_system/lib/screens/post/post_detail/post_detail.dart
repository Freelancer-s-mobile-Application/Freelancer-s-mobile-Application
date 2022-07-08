import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/Post.dart';
import '../post_list/components/content_view.dart';

class PostDetail extends StatelessWidget {
  const PostDetail(this._post, this.func);

  final Post _post;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _post.title.toString(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 1,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _post.status.toString(),
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.user,
                      size: 13,
                      color: Colors.blue,
                    ),
                    if (int.parse(_post.min.toString()) ==
                        int.parse(_post.max.toString()))
                      Text(
                        ' ${_post.min} needed',
                        style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    if (int.parse(_post.min.toString()) !=
                        int.parse(_post.max.toString()))
                      Text(
                        " ${_post.min} - ${_post.max} needed",
                        style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                  ],
                )
              ],
            ),
            const Divider(thickness: 2),
            ContentView(
              _post.content.toString(),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {},
                    child: const Text('Apply'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      func();
                    },
                    child: const Text(
                      'Contact Project Owner',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
