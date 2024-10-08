import 'package:flutter/material.dart';
import 'package:vocabkpop/components/Lesson.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/data_test/vocabulary_data.dart' as vocabulary_data;

class LibraryLesson extends StatelessWidget {
  final List<LessonModel> _listLesson = vocabulary_data.listLesson;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Bộ lọc',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        for (var lesson in _listLesson)
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/homeLesson',
                arguments: lesson.vocabulary,
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ngày ${lesson.dateCreate}',
                      style: const TextStyle(fontSize: 20, fontFamily: 'Lobster'),
                    ),
                  ),
                ),
                Lesson(lessonModel: lesson),
              ],
            ),
          ),
      ],
    );
  }
}
