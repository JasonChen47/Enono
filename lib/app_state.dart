import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'entry.dart';

class AppState {
  // String imageUrl = '';

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

  void writeEntryToFirebase(Entry entry) async {
    // FirebaseFirestore.instance.collection('Entries').add(<String, String>{
    //   'title': entry.title,
    //   'date': entry.date.toString(),
    //   'text': entry.text,
    // });
    if (entry.imageFile != null) {
      //   // Upload the image to Firebase Storage
      //   print('entered');

      //   //Get a reference to storage root
      //   Reference referenceRoot = FirebaseStorage.instance.ref();
      //   Reference referenceDirImages = referenceRoot.child('images');
      //   print('made reference to storage root');

      //   //Create a reference for the image to be stored
      //   Reference referenceImageToUpload = referenceDirImages.child('name');
      //   print('made reference for image to be stored');

      //   try {
      //     //Store the file
      //     await referenceImageToUpload.putFile(File(entry.imageFile!.path));
      //     //Success: get the download URL
      //     imageUrl = await referenceImageToUpload.getDownloadURL();
      //   } catch (error) {
      //     //Some error occurred
      //   }
      //   print('store the file');
      // print('entered');
      // final _id = Random().nextInt(999);

      // final _ref = FirebaseStorage.instance
      //     .ref("playground/images/")
      //     .child("image-$_id.jpg");
      // print('reference');
      // final UploadTask _task =
      //     (await _ref.putFile(File(entry.imageFile!.path))) as UploadTask;
      // _task.whenComplete(() {
      //   print("image uploaded");
      // });

      // final imageUrl = await _task.snapshot.ref.getDownloadURL();
      // print('getdownload');
// no need of the file extension, the name will do fine.
      // Rest of the code

      // Upload the image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('entry_image.jpg');
      UploadTask uploadTask = storageReference.putFile(entry.imageFile!);

      // Get the download URL of the uploaded image
      String imageUrl = await (await uploadTask).ref.getDownloadURL();

      print('get download URL');
      // Save entry details along with the image URL to Firestore
      await FirebaseFirestore.instance.collection('Entries').add({
        'title': entry.title,
        'date': entry.date.toString(),
        'text': entry.text,
        'image_url': imageUrl, // Save image URL in Firestore
      });
    } else {
      // If no image, save entry details without the image URL
      await FirebaseFirestore.instance.collection('Entries').add({
        'title': entry.title,
        'date': entry.date.toString(),
        'text': entry.text,
      });
      print('added to collection');
    }
  }

  Future<void> _listenForEntries() async {
    FirebaseFirestore.instance
        .collection('Entries')
        .snapshots()
        .listen((event) {
      final entries = event.docs.map((doc) {
        final data = doc.data();
        return Entry(
          date: data['date'] as String,
          text: data['text'] as String,
          title: data['title'] as String,
        );
      }).toList();

      _entriesStreamController.add(entries);
    });
  }
}

const lorem =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod  tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
    ''';
