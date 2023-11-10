import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  static const title = 'Search';
  static const androidIcon = Icon(Icons.search);
  static const iosIcon = Icon(CupertinoIcons.search);
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: 'initial text');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Search'),
        ),
        // child: Container(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: CupertinoSearchTextField(
        //       controller: textController,
        //       placeholder: 'Search',
        //     ),
        //   ),
        // ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
                //       controller: textController,
                //       placeholder: 'Search',
                ),
          ),
        ));
  }

  // @override
  // Widget build(context) {
  //   return Center(
  //     child: Container(
  //       child: Text('Search Page'),
  //     ),
  //   );
  // }
}
