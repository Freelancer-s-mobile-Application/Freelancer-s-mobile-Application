import 'package:flutter/material.dart';
import 'package:freelancer_system/constants/controller.dart';

class SearchMyList extends StatefulWidget {
  const SearchMyList({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchMyList> createState() => _SearchMyListState();
}

class _SearchMyListState extends State<SearchMyList> {
  TextEditingController searchCtl = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchCtl.addListener(() {
      if (searchCtl.text.isEmpty) {
        postController.isMySearch.trigger(false);
      } else {
        postController.isMySearch.trigger(true);
        postController.mySearchKey.value = searchCtl.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.blue),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: searchCtl,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  icon: const Icon(Icons.search),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    iconSize: 20,
                    onPressed: () {
                      searchCtl.clear();
                      postController.isSearch.trigger(false);
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
