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
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEEEEEE),
              ),
              child: Text(
                '${lessonModel.vocabulary.length} Thuật ngữ',
                style: const TextStyle(fontSize: 15, fontFamily: 'Lobster'),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(lessonModel.imageUser),
                ),
                const SizedBox(width: 5),
                Text(
                  lessonModel.creator,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
