import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/LessonModel.dart';

class LessonService {
  final CollectionReference classCollection = FirebaseFirestore.instance.collection('lesson');
  Future<bool> createLesson(LessonModel lessonModel) async {
    try {
      await classCollection.add(lessonModel.toMap());
      return true;
    } catch (e) {
      print('Error creating class: $e');
      return false;
    }
  }
}
