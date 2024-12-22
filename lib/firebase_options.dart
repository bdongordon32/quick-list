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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyADcjpar3slaog2kR9IfhUTw42Mu3WR1f0',
    appId: '1:977213189126:web:e94015d4d5c58ad5c72787',
    messagingSenderId: '977213189126',
    projectId: 'quick-33f6d',
    authDomain: 'quick-33f6d.firebaseapp.com',
    storageBucket: 'quick-33f6d.firebasestorage.app',
    measurementId: 'G-KL74S4Y0LR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAriv4Q-vgpV4KsW8_mUmxpzHZWOLYa_fM',
    appId: '1:977213189126:android:c7f9899085e3fc9fc72787',
    messagingSenderId: '977213189126',
    projectId: 'quick-33f6d',
    storageBucket: 'quick-33f6d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7bfPVYvrYxOUs9It0PZWbal-WIYx0Kbo',
    appId: '1:977213189126:ios:c5962f1c360fbaccc72787',
    messagingSenderId: '977213189126',
    projectId: 'quick-33f6d',
    storageBucket: 'quick-33f6d.firebasestorage.app',
    iosBundleId: 'com.example.quickList',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7bfPVYvrYxOUs9It0PZWbal-WIYx0Kbo',
    appId: '1:977213189126:ios:c5962f1c360fbaccc72787',
    messagingSenderId: '977213189126',
    projectId: 'quick-33f6d',
    storageBucket: 'quick-33f6d.firebasestorage.app',
    iosBundleId: 'com.example.quickList',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyADcjpar3slaog2kR9IfhUTw42Mu3WR1f0',
    appId: '1:977213189126:web:5bfd0abc4ae896fec72787',
    messagingSenderId: '977213189126',
    projectId: 'quick-33f6d',
    authDomain: 'quick-33f6d.firebaseapp.com',
    storageBucket: 'quick-33f6d.firebasestorage.app',
    measurementId: 'G-34JHVG35CV',
  );
}
