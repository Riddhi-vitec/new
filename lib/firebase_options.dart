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
    apiKey: 'AIzaSyBPBdKZ2BWwxlUOIGRBsHKfqFCnhjBRixA',
    appId: '1:60394012236:web:5f2e3e9d5a9159ee753ee9',
    messagingSenderId: '60394012236',
    projectId: 'vitec-back-end-template',
    authDomain: 'vitec-back-end-template.firebaseapp.com',
    storageBucket: 'vitec-back-end-template.appspot.com',
    measurementId: 'G-6E537E7BPM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGd5jlduZBU_OuU2qyqQvtccGvjQhTVZ0',
    appId: '1:60394012236:android:3d74981af07e678c753ee9',
    messagingSenderId: '60394012236',
    projectId: 'vitec-back-end-template',
    storageBucket: 'vitec-back-end-template.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCcR4hLxfrGbWd8_qYN6tnfW8LH1A6AeaI',
    appId: '1:60394012236:ios:58d08a53b30255a4753ee9',
    messagingSenderId: '60394012236',
    projectId: 'vitec-back-end-template',
    storageBucket: 'vitec-back-end-template.appspot.com',
    androidClientId: '60394012236-68mqudjmkm7tl5viiobr20eka4unptre.apps.googleusercontent.com',
    iosClientId: '60394012236-72qv5muhrkpgphi1t2i8bi108djsto94.apps.googleusercontent.com',
    iosBundleId: 'com.vitecvisual.fluttertemplates',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCcR4hLxfrGbWd8_qYN6tnfW8LH1A6AeaI',
    appId: '1:60394012236:ios:b6855d0ce0884838753ee9',
    messagingSenderId: '60394012236',
    projectId: 'vitec-back-end-template',
    storageBucket: 'vitec-back-end-template.appspot.com',
    androidClientId: '60394012236-68mqudjmkm7tl5viiobr20eka4unptre.apps.googleusercontent.com',
    iosClientId: '60394012236-usibj9uhcrm2s04be2fvkj2crijrvnaf.apps.googleusercontent.com',
    iosBundleId: 'com.example.templateFlutterMvvmRepoBloc.RunnerTests',
  );
}
