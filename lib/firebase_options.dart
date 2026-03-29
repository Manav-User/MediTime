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
        throw UnsupportedError(
            'DefaultFirebaseOptions have not been configured for macos.');
      case TargetPlatform.windows:
        throw UnsupportedError(
            'DefaultFirebaseOptions have not been configured for windows.');
      case TargetPlatform.linux:
        throw UnsupportedError(
            'DefaultFirebaseOptions have not been configured for linux.');
      default:
        throw UnsupportedError(
            'DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeu2Gkmc8IH5Nj0TLR_-7l6GbsF3cHUjo',
    appId: '1:491224634443:android:9da1f94e6723166f1d69ce',
    messagingSenderId: '491224634443',
    projectId: 'meditime-d8e38',
    storageBucket: 'meditime-d8e38.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAEDe5Dx2ap3JvvJUFajYVO0wwLBx_hB_k',
    appId: '1:491224634443:web:59eddd71cccdb7de1d69ce',
    messagingSenderId: '491224634443',
    projectId: 'meditime-d8e38',
    authDomain: 'meditime-d8e38.firebaseapp.com',
    storageBucket: 'meditime-d8e38.firebasestorage.app',
    measurementId: 'G-YYQLX3H43W',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqpTAWPFg2r5skCn_rg-sJhyRozQku7gg',
    appId: '1:491224634443:ios:c437e724e019241f1d69ce',
    messagingSenderId: '491224634443',
    projectId: 'meditime-d8e38',
    storageBucket: 'meditime-d8e38.firebasestorage.app',
    androidClientId: '491224634443-1vmdhppn12sev3umvq18naglarcgbcmo.apps.googleusercontent.com',
    iosClientId: '491224634443-s4qeeqi595d2c8npqam7gkamphmqmvr6.apps.googleusercontent.com',
    iosBundleId: 'com.manav.meditime',
  );

}