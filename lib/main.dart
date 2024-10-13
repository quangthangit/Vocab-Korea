import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/pages/CheckLoginPage.dart';
import 'package:vocabkpop/pages/CircularProgressIndicator.dart';
import 'package:vocabkpop/pages/CreateVocabularyPage.dart';
import 'package:vocabkpop/pages/HomeLessonPage.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;
import 'package:vocabkpop/pages/GameMatchPage.dart';
import 'package:vocabkpop/pages/MatchPage.dart';
import 'package:vocabkpop/pages/StudyPage.dart';
import 'package:vocabkpop/pages/FlashCardPage.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: app_color.AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: CheckLoginPage(),
    );
  }
}