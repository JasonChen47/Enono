// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';

import 'firebase_options.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_tab.dart';
import 'search_tab.dart';
import 'chat_tab.dart';
import 'profile_tab.dart';
import 'widgets.dart';
import 'app_state.dart';
import 'tabs_view.dart';
import 'logged_out_view.dart';

// void main() => runApp(const MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final state = AppState();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: AppScrollBehavior(),
      routerConfig: _router(),
      theme: ThemeData(useMaterial3: true),
    );
  }

  GoRouter _router() {
    return GoRouter(
      redirect: (context, routerState) => state.user == null ? '/login' : null,
      routes: [
        GoRoute(
          path: '/',
          // builder: (context, routerState) => TabsView(state: state),
          builder: (context, routerState) => TabsView(state: state),
        ),
        GoRoute(
          path: '/login',
          builder: (context, routerState) => LoggedOutView(state: state),
        ),
      ],
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
