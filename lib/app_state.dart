import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'project.dart';

class AppState {
  // String imageUrl = '';

  AppState() {
    print('again');
    _entriesStreamController = StreamController.broadcast(onListen: () {
      // _entriesStreamController.add([
      //   Entry(
      //     date: '10/09/2022',
      //     text: lorem,
      //     title: '[Example] My Journal Entry',
      //     imageURL: "https://picsum.photos/id/237/200/300",
      //   )
      // ]);
    });
  }

  // This will change to the type User from the Firebase Authentication package
  // Changing it’s type now would cause the app to throw an error
  User? user; // <-- changed variable type
  Stream<List<Project>> get entries => _entriesStreamController.stream;
  late final StreamController<List<Project>> _entriesStreamController;

  Future<void> logIn(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      user = credential.user!;
      listenForEntries();
    } else {
      print('no user!');
    }
  }

  void writeEntryToFirebase(Project project) async {
    if (project.imageURL != null) {
      // Upload the image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images')
          .child(DateTime.now().toString() + 'project_image.jpg');
      UploadTask uploadTask = storageReference.putFile(File(project.imageURL!));
      // Get the download URL of the uploaded image
      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      print('get download URL');
      // Save entry details along with the image URL to Firestore
      await FirebaseFirestore.instance.collection('Entries').add({
        'title': project.title,
        'date': project.date.toString(),
        'description': project.description,
        'skills': project.skills,
        'imageurl': imageUrl, // Save image URL in Firestore
      });
    } else {
      // If no image, save entry details without the image URL
      await FirebaseFirestore.instance.collection('Entries').add({
        'title': project.title,
        'date': project.date.toString(),
        'description': project.description,
        'skills': project.skills,
      });
      print('added to collection');
    }
  }

  Future<void> listenForEntries() async {
    FirebaseFirestore.instance
        .collection('Entries')
        .snapshots()
        .listen((event) {
      final entries = event.docs.map((doc) {
        final data = doc.data();
        return Project(
          date: data['date'] as String,
          description: data['description'] as String,
          title: data['title'] as String,
          skills: data['skills'] as List<dynamic>,
          imageURL: data['imageurl'] as String,
        );
      }).toList();

      _entriesStreamController.add(entries);
      print(entries);
    });
  }
}

const lorem =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
    ''';
