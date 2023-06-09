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
    apiKey: 'AIzaSyAXIkSraleqDYqn7_oWN-OU0JDUxdFKXUM',
    appId: '1:660334822645:web:3ce53d33e1d03a03c6f1bc',
    messagingSenderId: '660334822645',
    projectId: 'railways-flutter',
    authDomain: 'railways-flutter.firebaseapp.com',
    databaseURL: 'https://railways-flutter-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'railways-flutter.appspot.com',
    measurementId: 'G-R8QYRSBB25',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPYPZMpURLghNJcWrVQ4MfzDrEjU54jkM',
    appId: '1:660334822645:android:1754d6610a4d2785c6f1bc',
    messagingSenderId: '660334822645',
    projectId: 'railways-flutter',
    databaseURL: 'https://railways-flutter-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'railways-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6c8KpylKcTTl_7693aefTqE7nNjXtpfs',
    appId: '1:660334822645:ios:cbf5c787556da970c6f1bc',
    messagingSenderId: '660334822645',
    projectId: 'railways-flutter',
    databaseURL: 'https://railways-flutter-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'railways-flutter.appspot.com',
    iosClientId: '660334822645-0e3gd22hn69v2jmqsnivavpb944eb49h.apps.googleusercontent.com',
    iosBundleId: 'com.example.reservationRailway',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6c8KpylKcTTl_7693aefTqE7nNjXtpfs',
    appId: '1:660334822645:ios:cbf5c787556da970c6f1bc',
    messagingSenderId: '660334822645',
    projectId: 'railways-flutter',
    databaseURL: 'https://railways-flutter-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'railways-flutter.appspot.com',
    iosClientId: '660334822645-0e3gd22hn69v2jmqsnivavpb944eb49h.apps.googleusercontent.com',
    iosBundleId: 'com.example.reservationRailway',
  );
}