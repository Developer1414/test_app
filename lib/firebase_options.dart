// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB-orXNz4L5Ngkny7zEVU9OEbthlRMXIg0',
    appId: '1:51030620488:web:0fd072eb7f4e17af011b7d',
    messagingSenderId: '51030620488',
    projectId: 'test-app-a2d7a',
    authDomain: 'test-app-a2d7a.firebaseapp.com',
    storageBucket: 'test-app-a2d7a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDenolEpvcMGR--DrbxzL27GtNLh-H9TZI',
    appId: '1:51030620488:android:3db04b46b92bd395011b7d',
    messagingSenderId: '51030620488',
    projectId: 'test-app-a2d7a',
    storageBucket: 'test-app-a2d7a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDF8dbUHAeO_B1pUDbJGV_KAYpR-8IF0rU',
    appId: '1:51030620488:ios:a29e27b3ccf7542a011b7d',
    messagingSenderId: '51030620488',
    projectId: 'test-app-a2d7a',
    storageBucket: 'test-app-a2d7a.appspot.com',
    iosBundleId: 'com.testapp.app',
  );

}