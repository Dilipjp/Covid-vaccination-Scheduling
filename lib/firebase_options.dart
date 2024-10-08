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
    apiKey: 'AIzaSyC_qsXQ7mm8e15JDYlsK2d-rX03y_aMDUY',
    appId: '1:690704988607:web:650f5d49b81964be89890a',
    messagingSenderId: '690704988607',
    projectId: 'covid-app-73fd3',
    authDomain: 'covid-app-73fd3.firebaseapp.com',
    databaseURL: 'https://covid-app-73fd3-default-rtdb.firebaseio.com',
    storageBucket: 'covid-app-73fd3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC2lp7WhxG3DPZFECQO2hid0RBAiMCWXsk',
    appId: '1:690704988607:android:7aa35e9808d1dda289890a',
    messagingSenderId: '690704988607',
    projectId: 'covid-app-73fd3',
    databaseURL: 'https://covid-app-73fd3-default-rtdb.firebaseio.com',
    storageBucket: 'covid-app-73fd3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQ-HL39dyaOSfHE_6dh7wAGoQA9Kk0QUg',
    appId: '1:690704988607:ios:bc960a468316c63789890a',
    messagingSenderId: '690704988607',
    projectId: 'covid-app-73fd3',
    databaseURL: 'https://covid-app-73fd3-default-rtdb.firebaseio.com',
    storageBucket: 'covid-app-73fd3.appspot.com',
    iosBundleId: 'com.example.covidapp2.covidApp3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQ-HL39dyaOSfHE_6dh7wAGoQA9Kk0QUg',
    appId: '1:690704988607:ios:bc960a468316c63789890a',
    messagingSenderId: '690704988607',
    projectId: 'covid-app-73fd3',
    databaseURL: 'https://covid-app-73fd3-default-rtdb.firebaseio.com',
    storageBucket: 'covid-app-73fd3.appspot.com',
    iosBundleId: 'com.example.covidapp2.covidApp3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC_qsXQ7mm8e15JDYlsK2d-rX03y_aMDUY',
    appId: '1:690704988607:web:cadbac072de2f5a989890a',
    messagingSenderId: '690704988607',
    projectId: 'covid-app-73fd3',
    authDomain: 'covid-app-73fd3.firebaseapp.com',
    databaseURL: 'https://covid-app-73fd3-default-rtdb.firebaseio.com',
    storageBucket: 'covid-app-73fd3.appspot.com',
  );
}
