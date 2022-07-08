import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../models/Post.dart';
import '../../post_detail/post_screen.dart';
import '../../../../addons/content_limitter.dart';
import 'content_view.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title.toString(),
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1,
                    letterSpacing: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ContentLimitter(
                          maxHeight: Get.height * 0.1,
                          child: ContentView(post.content.toString()),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    post.status.toString(),
                    style: GoogleFonts.kanit(
                        fontWeight: FontWeight.w500, color: getColor()),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.user,
                      size: 13,
                      color: Colors.blue,
                    ),
                    if (int.parse(post.min.toString()) ==
                        int.parse(post.max.toString()))
                      Text(
                        ' ${post.min}',
                        style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    if (int.parse(post.min.toString()) !=
                        int.parse(post.max.toString()))
                      Text(
                        " ${post.min} - ${post.max}",
                        style: GoogleFonts.kanit(
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    const Spacer(),
                    Text(
                      DateFormat('dd/MM/yyyy').format(post.createdDate!),
                      style: GoogleFonts.kanit(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor() {
    if (post.status.toString() == 'open') {
      return Colors.green;
    } else {
      return Colors.amber.shade300;
    }
  }
}
