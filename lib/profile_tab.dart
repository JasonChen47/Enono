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
                    'Artist, Writer, Musician', // Replace with user's email or additional info
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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
  List<String> skills = [
    'Canoeing',
    'Writing',
    'App Dev',
    'Cooking',
    'Dancing'
  ];
  List<String> resources = ['House', 'MRI Machine', 'Phone'];

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My goal is to improve the wellbeing of dolphins around the world',
            textAlign: TextAlign.center,
            style: TextStyle(
              // Makes the text bold
              fontSize: 15, // Adjusts the font size
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Skills',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              for (var skill in skills) Chip(label: Text(skill))
            ],
          ),
          SizedBox(height: 15),
          Text(
            'Resources',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: <Widget>[
              for (var resource in resources) Chip(label: Text(resource))
            ],
          ),
        ],
      ),
    );
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
