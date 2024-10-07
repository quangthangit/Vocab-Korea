import 'package:flutter/material.dart';
import 'package:vocabkpop/models/Vocabulary.dart';
import 'package:vocabkpop/widget/QuizWidget.dart';
import 'dart:math';
import 'package:vocabkpop/widget/StudyBar.dart';
import 'package:vocabkpop/data_test/vocabulary_data.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: QuizWidget(),
      ),
    );
  }
}
