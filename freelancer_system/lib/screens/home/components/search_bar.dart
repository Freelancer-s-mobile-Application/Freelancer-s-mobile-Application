import 'package:flutter/material.dart';

import '../../../constants/controller.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchCtl = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchCtl.addListener(() {
      if (searchCtl.text.isEmpty) {
        postController.isSearch.trigger(false);
      } else {
        postController.isSearch.trigger(true);
        postController.searchKey.value = searchCtl.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
