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
    apiKey: 'AIzaSyD9sKQSxT47Tg3Bqhne4icyHg2aYGVC5xM',
    appId: '1:1008349420902:web:f1a30ca8025729fed0fca7',
    messagingSenderId: '1008349420902',
    projectId: 'cvvapp-fc6be',
    authDomain: 'cvvapp-fc6be.firebaseapp.com',
    storageBucket: 'cvvapp-fc6be.appspot.com',
    measurementId: 'G-XF3JYG6YGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCxzuKm3fwA1-OLtiGTBJMRSrBvUnC13qw',
    appId: '1:1008349420902:android:21081022af160c14d0fca7',
    messagingSenderId: '1008349420902',
    projectId: 'cvvapp-fc6be',
    storageBucket: 'cvvapp-fc6be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhu7b8PJE3ub_VHNGQYJzU_DNFr2r6I6g',
    appId: '1:1008349420902:ios:71bad790168acd88d0fca7',
    messagingSenderId: '1008349420902',
    projectId: 'cvvapp-fc6be',
    storageBucket: 'cvvapp-fc6be.appspot.com',
    iosBundleId: 'com.codeforany.foodDelivery',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAhu7b8PJE3ub_VHNGQYJzU_DNFr2r6I6g',
    appId: '1:1008349420902:ios:03d9401281df04a4d0fca7',
    messagingSenderId: '1008349420902',
    projectId: 'cvvapp-fc6be',
    storageBucket: 'cvvapp-fc6be.appspot.com',
    iosBundleId: 'com.codeforany.foodDelivery.RunnerTests',
  );
}
