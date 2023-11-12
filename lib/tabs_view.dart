import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'home_tab.dart';
import 'search_tab.dart';
import 'chat_tab.dart';
import 'profile_tab.dart';
import 'widgets.dart';
import 'app_state.dart';

// class TabsView extends StatefulWidget {

//   const TabsView({super.key});

//   @override
//   State<TabsView> createState() => _TabsViewState();
// }

class TabsView extends StatelessWidget {
  final AppState state;
  TabsView({super.key, required this.state});

  @override
  Widget build(context) {
    // Either Material or Cupertino widgets work in either Material or Cupertino
    // Apps.
    return MaterialApp(
      title: 'Adaptive Music App',
      theme: ThemeData(
        // Use the green theme for Material widgets.
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      builder: (context, child) {
        return CupertinoTheme(
          // Instead of letting Cupertino widgets auto-adapt to the Material
          // theme (which is green), this app will use a different theme
          // for Cupertino (which is blue by default).
          data: const CupertinoThemeData(),
          child: Material(child: child),
        );
      },
      home: const PlatformAdaptingHomePage(),
    );
  }
}

// Shows a different type of scaffold depending on the platform.
class PlatformAdaptingHomePage extends StatefulWidget {
  const PlatformAdaptingHomePage({super.key});

  @override
  State<PlatformAdaptingHomePage> createState() =>
      _PlatformAdaptingHomePageState();
}

class _PlatformAdaptingHomePageState extends State<PlatformAdaptingHomePage> {
  Widget _buildAndroidHomePage(BuildContext context) {
    return HomeTab();
  }

  Widget _buildIosHomePage(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            label: HomeTab.title,
            icon: HomeTab.iosIcon,
          ),
          BottomNavigationBarItem(
            label: SearchTab.title,
            icon: SearchTab.iosIcon,
          ),
          BottomNavigationBarItem(
            label: ChatTab.title,
            icon: ChatTab.iosIcon,
          ),
          BottomNavigationBarItem(
            label: ProfileTab.title,
            icon: ProfileTab.iosIcon,
          )
        ],
      ),
      tabBuilder: (context, index) {
        assert(index <= 3 && index >= 0, 'Unexpected tab index: $index');
        return switch (index) {
          0 => CupertinoTabView(
              defaultTitle: HomeTab.title,
              builder: (context) => HomeTab(),
            ),
          1 => CupertinoTabView(
              defaultTitle: SearchTab.title,
              builder: (context) => SearchTab(),
            ),
          2 => CupertinoTabView(
              defaultTitle: ChatTab.title,
              builder: (context) => ChatTab(),
            ),
          3 => CupertinoTabView(
              defaultTitle: ProfileTab.title,
              builder: (context) => ProfileTab(),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroidHomePage,
      iosBuilder: _buildIosHomePage,
    );
  }
}

class _AndroidDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.green),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Icon(
                Icons.account_circle,
                color: Colors.green.shade800,
                size: 96,
              ),
            ),
          ),
          ListTile(
            leading: HomeTab.androidIcon,
            title: const Text(HomeTab.title),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: SearchTab.androidIcon,
            title: const Text(SearchTab.title),
            onTap: () {
              Navigator.pop(context);
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) => SearchTab()));
            },
          ),
          ListTile(
            leading: ChatTab.androidIcon,
            title: const Text(ChatTab.title),
            onTap: () {
              Navigator.pop(context);
              Navigator.push<void>(
                  context, MaterialPageRoute(builder: (context) => ChatTab()));
            },
          ),
          ListTile(
            leading: ProfileTab.androidIcon,
            title: const Text(ProfileTab.title),
            onTap: () {
              Navigator.pop(context);
              Navigator.push<void>(context,
                  MaterialPageRoute(builder: (context) => ProfileTab()));
            },
          )
        ],
      ),
    );
  }
}
