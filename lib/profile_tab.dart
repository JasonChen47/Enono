import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'utils.dart';
import 'widgets.dart';

class ProfileTab extends StatefulWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);
  static const iosIcon = Icon(CupertinoIcons.person);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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
                text: 'About',
              ),
              Tab(
                text: 'Projects',
              )
            ],
          ),
        )),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: AboutPage(),
            ),
            Center(child: ProjectsPage())
          ],
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Profile'),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                        'assets/ryan.jpeg'), // Replace with your image
                  ),
                  SizedBox(height: 20),
                  Text(
                    'John Doe', // Replace with the user's name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'john.doe@example.com', // Replace with user's email or additional info
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Action when the button is pressed
                    },
                    child: Text('Edit Profile'),
                  ),
                  Expanded(child: _tabBar(context)),
                ],
              ),
            ),
          ),
        ));
  }
}

class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Text('About Page');
  }
}

// Projects Page
class ProjectsPage extends StatefulWidget {
  static const _itemsLength = 20;
  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with AutomaticKeepAliveClientMixin {
  late final List<Color> colors;
  late final List<String> titles;
  late final List<String> contents;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    colors = getRandomColors(ProjectsPage._itemsLength);
    titles = List.generate(
        ProjectsPage._itemsLength, (index) => generateRandomHeadline());
    contents = List.generate(
        ProjectsPage._itemsLength, (index) => lorem(paragraphs: 1, words: 24));
    super.initState();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      itemCount: ProjectsPage._itemsLength,
      itemBuilder: (BuildContext context, int index) {
        return listBuilderProjects(
            context, index, titles, colors); // Using the listBuilder function
      },
    );
  }
}
