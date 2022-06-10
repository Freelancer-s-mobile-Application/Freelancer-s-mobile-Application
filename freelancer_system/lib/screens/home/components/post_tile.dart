import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostTile extends StatelessWidget {
  const PostTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TO-DO Go to Post Detail
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Job Title',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Job Description',
                      maxLines: 5,
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
                    child: const Text('Job Requirement'),
                  ),
                  Row(
                    children: const [
                      Icon(
                        FontAwesomeIcons.user,
                        size: 13,
                      ),
                      Text(' 5')
                    ],
                  ),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.red,
                  ),
                  Text('\$300-\$500'),
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Apply'),
                  ),
                  Text('3 days ago'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
