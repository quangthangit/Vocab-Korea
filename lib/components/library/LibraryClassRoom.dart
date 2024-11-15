import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/components/ClassRoom.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/models/ClassModel.dart';

class LibraryClassRoom extends StatelessWidget {
  final ClassService _classService = ClassService();

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return ListView(
      children: [
        const SizedBox(height: 10),
        FutureBuilder<List<ClassModel>>(
          future: userId != null ? _classService.getClassesExcludingUserId(userId) : Future.value([]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No classes found.'));
            }
            final classes = snapshot.data!;

            return Column(
              children: [
                ...classes.map((classModel) => ClassRoom(classModel: classModel)).toList(),
              ],
            );
          },
        ),
      ],
    );
  }
}