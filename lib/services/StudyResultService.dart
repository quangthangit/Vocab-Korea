import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/StudyResultModel.dart';

class StudyResultService {
  final CollectionReference studyResultCollection = FirebaseFirestore.instance
      .collection('studyResult');

  Future<DocumentReference?> createStudyResult(StudyResultModel studyResult) async {
    try {
      DocumentReference docRef = await studyResultCollection.add(studyResult.toMap());
      return docRef;
    } catch (e) {
      print('Error creating study result: $e');
      return null;
    }
  }
}
