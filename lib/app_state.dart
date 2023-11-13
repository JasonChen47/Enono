import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'entry.dart';

class AppState {
  AppState() {
    _entriesStreamController = StreamController.broadcast(onListen: () {
      _entriesStreamController.add([
        Entry(
          date: '10/09/2022',
          text: lorem,
          title: '[Example] My Journal Entry',
        )
      ]);
    });
  }

  // This will change to the type User from the Firebase Authentication package
  // Changing it’s type now would cause the app to throw an error
  User? user; // <-- changed variable type
  Stream<List<Entry>> get entries => _entriesStreamController.stream;
  late final StreamController<List<Entry>> _entriesStreamController;

  Future<void> logIn(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      user = credential.user!;
      _listenForEntries();
    } else {
      print('no user!');
    }
  }

  void writeEntryToFirebase(Entry entry) {
    FirebaseFirestore.instance.collection('Entries').add(<String, String>{
      'title': entry.title,
      'date': entry.date.toString(),
      'text': entry.text,
    });
  }

  Future<void> _listenForEntries() async {
    print('TODO: AppState._listenForEntries');
  }
}

const lorem =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
    ''';
