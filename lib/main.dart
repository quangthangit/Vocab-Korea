import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabkpop/pages/CheckLoginPage.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;

import 'package:firebase_core/firebase_core.dart';
import 'package:vocabkpop/pages/ResultSearchPage.dart';

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
      home: CheckLoginPage(),
    );
  }
}