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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDFeISPW47NK0Mw1C-iFjiXQFOcfhEI98',
    appId: '1:241432358313:android:256b715b2ac755e12328b8',
    messagingSenderId: '241432358313',
    projectId: 'quickdrop-ebc08',
    storageBucket: 'quickdrop-ebc08.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC04yLhw1VDp52ohlYGcOii5AZV9jMQZM0',
    appId: '1:241432358313:ios:582be31430dcc6f02328b8',
    messagingSenderId: '241432358313',
    projectId: 'quickdrop-ebc08',
    storageBucket: 'quickdrop-ebc08.appspot.com',
    androidClientId: '241432358313-1pjm5ldlgc2ohgmqsf0csi20v22g4vd4.apps.googleusercontent.com',
    iosClientId: '241432358313-8mfdakgoh6bc72ioln3hqmtd5v0dqqhv.apps.googleusercontent.com',
    iosBundleId: 'com.crossdev.quickdropSellers',
  );

}