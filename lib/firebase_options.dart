// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBp4uzdd4MnUR2bpIrDI3BFae6u5JL5xNQ',
    appId: '1:839345937146:web:489873fc145d060ed2c743',
    messagingSenderId: '839345937146',
    projectId: 'ivyisquizzy-app',
    authDomain: 'ivyisquizzy-app.firebaseapp.com',
    storageBucket: 'ivyisquizzy-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1paSOsEOsrXBSwn-BH_GvaQAAnSq05Ww',
    appId: '1:839345937146:android:9a10f98323994f21d2c743',
    messagingSenderId: '839345937146',
    projectId: 'ivyisquizzy-app',
    storageBucket: 'ivyisquizzy-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVDpysmJjnn_S0wXecBlRjOu8zUHJGRKw',
    appId: '1:839345937146:ios:4668f29b47653778d2c743',
    messagingSenderId: '839345937146',
    projectId: 'ivyisquizzy-app',
    storageBucket: 'ivyisquizzy-app.appspot.com',
    iosBundleId: 'com.example.quizApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDVDpysmJjnn_S0wXecBlRjOu8zUHJGRKw',
    appId: '1:839345937146:ios:a1b1a482f0761022d2c743',
    messagingSenderId: '839345937146',
    projectId: 'ivyisquizzy-app',
    storageBucket: 'ivyisquizzy-app.appspot.com',
    iosBundleId: 'com.example.quizApp.RunnerTests',
  );
}
