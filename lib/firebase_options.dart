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
    apiKey: 'AIzaSyCDmRiPPpRmYZ8nwjNcJTbREOHtN24TVF4',
    appId: '1:984320095104:web:2184fa7164bef55712c765',
    messagingSenderId: '984320095104',
    projectId: 'graduation-project-214bf',
    authDomain: 'graduation-project-214bf.firebaseapp.com',
    storageBucket: 'graduation-project-214bf.firebasestorage.app',
    measurementId: 'G-LL0X2B9N6Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgZJkbmvzPpDvpHhCAaqVFDqjSUOJkpFQ',
    appId: '1:984320095104:android:4085fa6034f0ffc512c765',
    messagingSenderId: '984320095104',
    projectId: 'graduation-project-214bf',
    storageBucket: 'graduation-project-214bf.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXe0CZLhjscrWOmnEqStdvdM3bHcANzME',
    appId: '1:984320095104:ios:2a0b8df3e733733812c765',
    messagingSenderId: '984320095104',
    projectId: 'graduation-project-214bf',
    storageBucket: 'graduation-project-214bf.firebasestorage.app',
    androidClientId: '984320095104-4p501vvaeo6246ldkp9j6uthurnn5dde.apps.googleusercontent.com',
    iosClientId: '984320095104-6f84d6h37ccdeutc9nbvp41e3vhkcog5.apps.googleusercontent.com',
    iosBundleId: 'com.example.grauationProjectDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXe0CZLhjscrWOmnEqStdvdM3bHcANzME',
    appId: '1:984320095104:ios:2a0b8df3e733733812c765',
    messagingSenderId: '984320095104',
    projectId: 'graduation-project-214bf',
    storageBucket: 'graduation-project-214bf.firebasestorage.app',
    androidClientId: '984320095104-4p501vvaeo6246ldkp9j6uthurnn5dde.apps.googleusercontent.com',
    iosClientId: '984320095104-6f84d6h37ccdeutc9nbvp41e3vhkcog5.apps.googleusercontent.com',
    iosBundleId: 'com.example.grauationProjectDashboard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCDmRiPPpRmYZ8nwjNcJTbREOHtN24TVF4',
    appId: '1:984320095104:web:7abf9439dcf11d4512c765',
    messagingSenderId: '984320095104',
    projectId: 'graduation-project-214bf',
    authDomain: 'graduation-project-214bf.firebaseapp.com',
    storageBucket: 'graduation-project-214bf.firebasestorage.app',
    measurementId: 'G-NLVGE3QS5P',
  );

}