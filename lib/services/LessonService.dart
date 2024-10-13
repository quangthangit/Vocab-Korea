import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/LessonModel.dart';

class LessonService {
  final CollectionReference lessonCollection = FirebaseFirestore.instance.collection('lesson');
  Future<bool> createLesson(LessonModel lessonModel) async {
    try {
      await lessonCollection.add(lessonModel.toMap());
      return true;
    } catch (e) {
      print('Error creating class: $e');
      return false;
    }
  }

  Future<List<LessonModel>> getLessonByUser(String userId) async {
    try {
      QuerySnapshot querySnapshot = await lessonCollection
          .where('idMember', arrayContains: userId)
          .get();

      List<LessonModel> lesson = querySnapshot.docs.map((doc) {
        return LessonModel.fromFirestore(doc);
      }).toList();

      return lesson;
    } catch (e) {
      print('Error getting classes: $e');
      return [];
    }
  }
}
