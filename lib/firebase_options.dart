import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web; 
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyClMEi8L5CnW3yUl2lEfh5NuKgq6Yw0yc0",
    authDomain: "sup4-dev-fluttertrello.firebaseapp.com",
    projectId: "sup4-dev-fluttertrello",
    storageBucket: "sup4-dev-fluttertrello.appspot.com",
    messagingSenderId: "637152255887",
    appId: "1:637152255887:web:dce0877a6be22f332e35fa",
    measurementId: "G-SMDS4F7TV2",
  );
}