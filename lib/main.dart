import 'package:firebase/screens/match_list.dart';
import 'package:firebase/services/firesbase_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // This should import the generated file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // This should be defined in firebase_options.dart
  );
  await FirebaseNotificationService.instance.initialize();
  runApp(const MyApp());
}

extension on FirebaseNotificationService {
  initialize() {}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LiveScoreScreen(),
    );
  }
}
