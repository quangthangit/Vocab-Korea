import 'package:flutter/material.dart';
import 'package:vocabkpop/components/ClassRoom.dart';
import 'package:vocabkpop/components/Lesson.dart';

class LibraryClassRoom extends StatelessWidget {
  const LibraryClassRoom({super.key});

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
        const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Tuần này', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),
              ),
            ),
            ClassRoom()
          ],
        ),
        const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Tháng 10 2024', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),
              ),
            ),
            ClassRoom()
          ],
        ),
        const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Tháng 9 2024', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),
              ),
            ),
            ClassRoom()
          ],
        ),
      ],
    );
  }
}
