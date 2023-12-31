// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD6-QyY9aWqIv_oUDhIul0PS-k5xFGU_rw',
    appId: '1:740899552773:web:8f6f4e7eedd32bcf9e666c',
    messagingSenderId: '740899552773',
    projectId: 'enono-4747',
    authDomain: 'enono-4747.firebaseapp.com',
    storageBucket: 'enono-4747.appspot.com',
    measurementId: 'G-Z5RQX2DBCT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6AZcHQz7oYuLLQVomddxzJrkH0lJsgBo',
    appId: '1:740899552773:android:12cae5832bf4b0fa9e666c',
    messagingSenderId: '740899552773',
    projectId: 'enono-4747',
    storageBucket: 'enono-4747.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBo01uvrwAS_mwfF3XRnD1HV9-Af_lQ_ao',
    appId: '1:740899552773:ios:9a6ca71246b49b3a9e666c',
    messagingSenderId: '740899552773',
    projectId: 'enono-4747',
    storageBucket: 'enono-4747.appspot.com',
    iosBundleId: 'com.example.enono',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBo01uvrwAS_mwfF3XRnD1HV9-Af_lQ_ao',
    appId: '1:740899552773:ios:ac032451b4a0d8fb9e666c',
    messagingSenderId: '740899552773',
    projectId: 'enono-4747',
    storageBucket: 'enono-4747.appspot.com',
    iosBundleId: 'com.example.enono.RunnerTests',
  );
}
