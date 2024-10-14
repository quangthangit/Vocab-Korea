import 'package:flutter/material.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/pages/HomeLessonPage.dart';

class Lesson extends StatelessWidget {
  final LessonModel lessonModel;

  const Lesson({super.key, required this.lessonModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeLessonPage(lessonModel: lessonModel),),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lessonModel.title,
              style: const TextStyle(fontSize: 20, fontFamily: 'Lobster'),
            ),
            const SizedBox(height: 20),
            Text(
              '${lessonModel.vocabulary.length} Thuật ngữ',
              style: const TextStyle(fontSize: 15, fontFamily: 'Lobster'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.account_circle_outlined),
                const SizedBox(width: 5),
                Text(
                  lessonModel.creator,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'KayPhoDu'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
