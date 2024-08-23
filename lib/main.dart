import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/SplashScreen/index.dart';
import 'package:firebase/screens/match_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // This should import the generated file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // This should be defined in firebase_options.dart
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> _getData() async {
    final match = await firebaseFirestore
        .collection("football")
        .get(); // Await the async operation
    for (var doc in match.docs) {
      print(doc.data().toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

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
