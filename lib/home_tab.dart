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
  Widget _tabBar(BuildContext context) {
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
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ProjectsPage(),
            ),
            Center(child: PeoplePage())
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
        navigationBar: const CupertinoNavigationBar(), child: _tabBar(context));
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

// Projects Page
class ProjectsPage extends StatelessWidget {
  Widget _listBuilder(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            elevation: 1.5,
            // margin: const EdgeInsets.fromLTRB(15, 12, 15, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(100.0),
              child: Text('Insert image here'),
            )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child:
                Text('Header', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Description blah blah blah'),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: PeoplePage._itemsLength,
      itemBuilder: _listBuilder,
    );
  }
}

// People Page
class PeoplePage extends StatefulWidget {
  static const _itemsLength = 20;

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage>
    with AutomaticKeepAliveClientMixin {
  late final List<Color> colors;
  late final List<String> titles;
  late final List<String> contents;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    colors = getRandomColors(PeoplePage._itemsLength);
    titles = List.generate(
        PeoplePage._itemsLength, (index) => generateRandomHeadline());
    contents = List.generate(
        PeoplePage._itemsLength, (index) => lorem(paragraphs: 1, words: 24));
    super.initState();
  }

  Widget _listBuilder(BuildContext context, int index) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Card(
        elevation: 1.5,
        margin: const EdgeInsets.fromLTRB(6, 12, 6, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          // Make it splash on Android. It would happen automatically if this
          // was a real card but this is just a demo. Skip the splash on iOS.
          onTap: defaultTargetPlatform == TargetPlatform.iOS ? null : () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: colors[index],
                  child: Text(
                    titles[index].substring(0, 1),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                        contents[index],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: PeoplePage._itemsLength,
      itemBuilder: _listBuilder,
    );
  }
}
