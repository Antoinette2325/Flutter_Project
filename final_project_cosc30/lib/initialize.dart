import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart'; // Import WidgetsFlutterBinding
import 'package:flutter/foundation.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAyZUMsjW_8TUPSfQOJfZrFllbI5Em5S1E',
          appId: '1:237973476884:android:e5745c8ea1575234fdb901',
          messagingSenderId: '237973476884',
          projectId: 'finalproject-10191',
          storageBucket: 'finalproject-10191.appspot.com'
          // Your web Firebase config options
          ),
    );
  } else {
    await Firebase.initializeApp();
  }
}
