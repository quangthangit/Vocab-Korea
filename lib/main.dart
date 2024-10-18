import 'package:flutter/material.dart';
import 'package:vocabkpop/models/StudyResultModel.dart';
import 'package:vocabkpop/pages/CheckLoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vocabkpop/pages/Study/StudyResultPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: CheckLoginPage()
    );
  }
}