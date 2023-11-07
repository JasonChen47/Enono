import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'utils.dart';
import 'widgets.dart';

class HomeTab extends StatefulWidget {
  static const title = 'Home';
  static const androidIcon = Icon(Icons.home);
  static const iosIcon = Icon(CupertinoIcons.home);

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  static const _itemsLength = 20;

  late final List<Color> colors;
  late final List<String> titles;
  late final List<String> contents;

  @override
  void initState() {
    colors = getRandomColors(_itemsLength);
    titles = List.generate(_itemsLength, (index) => generateRandomHeadline());
    contents =
        List.generate(_itemsLength, (index) => lorem(paragraphs: 1, words: 24));
    super.initState();
  }

  Widget _tabBar(BuildContext context) {
    // return Center(child: Text('hi'));
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            flexibleSpace: const SafeArea(
          child: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Projects',
              ),
              Tab(
                text: 'People',
              )
            ],
          ),
        )),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("Add projects here"),
            ),
            Center(
              child: Text("Add people here"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(HomeTab.title),
        ),
        body: _tabBar(context));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(),
        // child: Text('hi')
        child: _tabBar(context));
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Projects');
  }
}

class PeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('People');
  }
}
