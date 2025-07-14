import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:handspeak/screens/splash_screen.dart';
import 'package:handspeak/screens/login_screen.dart';
import 'package:handspeak/screens/signup_screen.dart';
import 'package:handspeak/screens/home_screen.dart';
import 'package:handspeak/screens/learn_screen.dart';
import 'package:handspeak/screens/practice_screen.dart';
import 'package:handspeak/screens/profile_screen.dart';
import 'package:handspeak/screens/avatar_translate_screen.dart';
import 'package:handspeak/screens/learn/alphabet_screen.dart';
import 'package:handspeak/screens/learn/numbers_screen.dart';
import 'package:handspeak/screens/learn/greetings_screen.dart';
import 'package:handspeak/screens/learn/phrases_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hide system overlays for immersive splash
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // Firebase Initialization
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC9wFAZNmBKgQIolYewKCaEQTShxjDrz6s",
        authDomain: "handspeak-app.firebaseapp.com",
        projectId: "handspeak-app",
        storageBucket: "handspeak-app.appspot.com",
        messagingSenderId: "855981092769",
        appId: "1:855981092769:web:275e82a241eca16af0a5e0",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const HandSpeakApp());
}

class HandSpeakApp extends StatelessWidget {
  const HandSpeakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandSpeak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/learn': (context) => const LearnScreen(),
        '/practice': (context) => const PracticeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/translate': (context) => const AvatarTranslateScreen(),
        // Optional: Learn subcategory routes
        '/alphabet': (context) => const AlphabetScreen(),
        '/numbers': (context) => const NumbersScreen(),
        '/greetings': (context) => const GreetingsScreen(),
        '/phrases': (context) => const PhrasesScreen(),
      },
    );
  }
}
