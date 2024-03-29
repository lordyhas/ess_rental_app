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
    apiKey: 'AIzaSyDP4xC71bNYXBp4eSOpx_k9zIgs58Gaz_Q',
    appId: '1:109870721627:web:3798e65ce96104b3372d7e',
    messagingSenderId: '109870721627',
    projectId: 'exploressrental',
    authDomain: 'exploressrental.firebaseapp.com',
    storageBucket: 'exploressrental.appspot.com',
    measurementId: 'G-MSQ01EFXQ7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBls2SZwKm-oGsaD5ZnFOSLer2pSawc8Rw',
    appId: '1:109870721627:android:aca0489a7cd26621372d7e',
    messagingSenderId: '109870721627',
    projectId: 'exploressrental',
    storageBucket: 'exploressrental.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdSbKVbYTAOHTadTInkIWd7rCaLErImGQ',
    appId: '1:109870721627:ios:ff79150702e17cda372d7e',
    messagingSenderId: '109870721627',
    projectId: 'exploressrental',
    storageBucket: 'exploressrental.appspot.com',
    androidClientId: '109870721627-a94jfu7j2f4610aiklqsq0qc7d5njk4j.apps.googleusercontent.com',
    iosClientId: '109870721627-som3jtqiu5hjkelv2cqds5stc2lsh8ca.apps.googleusercontent.com',
    iosBundleId: 'com.kdynamic.exploress.kodisha',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdSbKVbYTAOHTadTInkIWd7rCaLErImGQ',
    appId: '1:109870721627:ios:4bf544996f863671372d7e',
    messagingSenderId: '109870721627',
    projectId: 'exploressrental',
    storageBucket: 'exploressrental.appspot.com',
    androidClientId: '109870721627-a94jfu7j2f4610aiklqsq0qc7d5njk4j.apps.googleusercontent.com',
    iosClientId: '109870721627-9e7ljrj2uq4f330mg2neuf729vcfeam0.apps.googleusercontent.com',
    iosBundleId: 'com.kdynamic.exploress.loaction.exploressLocation',
  );
}
