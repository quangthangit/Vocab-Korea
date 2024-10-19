import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/components/Lesson.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'dart:developer' as dev;

import 'package:vocabkpop/services/LessonService.dart';

class LibraryLesson extends StatelessWidget {
  final LessonService _lessonService = LessonService();

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return ListView(
      children: [
        const SizedBox(height: 10),
        FutureBuilder<List<LessonModel>>(
          future: userId != null ? _lessonService.getLessonByUser(userId) : Future.value([]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No lesson found.'));
            }
            final lesson = snapshot.data!;

            return Column(
              children: [
                ...lesson.map((lessonModel) => Lesson(lessonModel: lessonModel)).toList(),
              ],
            );
          },
        ),
      ],
    );
  }
}
