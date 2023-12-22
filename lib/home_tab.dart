import 'package:enono/project_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'utils.dart';
import 'widgets.dart';

import 'new_project.dart';
import 'app_state.dart';
import 'project.dart';

class HomeTab extends StatefulWidget {
  static const title = 'Home';
  static const androidIcon = Icon(Icons.home);
  static const iosIcon = Icon(CupertinoIcons.home);

  final AppState state;
  HomeTab({super.key, required this.state});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  late final AppState _appState; // Declare AppState variable

  @override
  void initState() {
    super.initState();
    _appState = widget.state; // Initialize AppState from widget parameter
    _startListeningForEntries(); // Start listening for entries
  }

  void _startListeningForEntries() {
    _appState.listenForEntries(); // Call _listenForEntries() from AppState
  }

  @override
  bool get wantKeepAlive => true;

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
              child: ProjectsPage(
                state: this.widget.state,
              ),
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
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Feed'),
        ),
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

// Projects Page
class ProjectsPage extends StatefulWidget {
  final AppState state;
  ProjectsPage({super.key, required this.state});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget _listBuilder(BuildContext context, int index, List<Project> entries) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to the second screen when the card is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProjectDetail(
                        state: widget.state, project: entries[index])),
              );
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  entries[index].imageURL != null
                      ? CachedNetworkImage(
                          imageUrl: entries[index].imageURL!,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Text('Image not found'),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(entries[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(entries[index].imageURL!,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(entries[index].description),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<Project>>(
          stream: widget.state.entries,
          initialData: const [],
          builder: (context, snapshot) {
            final allEntries = snapshot.data;
            return Scaffold(
              body: ListView.builder(
                itemCount: allEntries?.length,
                itemBuilder: (BuildContext context, int index) {
                  return _listBuilder(context, index,
                      allEntries!); // Using the listBuilder function
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewProject(
                              state: widget.state,
                            )),
                  );
                },
                child: const Icon(Icons.add),
              ),
            );
          }),
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
        PeoplePage._itemsLength, (index) => generateRandomHeadline());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: PeoplePage._itemsLength,
      itemBuilder: (BuildContext context, int index) {
        return listBuilderPeople(
            context, index, titles, colors); // Using the listBuilder function
      },
    );
  }
}
