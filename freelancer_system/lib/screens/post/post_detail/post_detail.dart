import 'package:flutter/material.dart';

import '../../../models/Post.dart';

class PostDetail extends StatelessWidget {
  const PostDetail(this._post);

  final Post _post;

  @override
  Widget build(BuildContext context) {
    //return a detail page
    return Container(
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
            Text(
              _post.status.toString(),
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
            Text(
              '${_post.min} - ${_post.max}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 2),
            Text(
              _post.content.toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
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
                    onPressed: () {},
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
