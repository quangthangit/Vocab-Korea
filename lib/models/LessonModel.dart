import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';

class LessonModel {
  String id;
  final String title;
  final String description;
  final String creator;
  final List<VocabularyModel> vocabulary;
  final DateTime dateCreate;

  LessonModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.creator,
    required this.vocabulary,
    required this.dateCreate,
  });

  factory LessonModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LessonModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      creator: data['creator'] ?? '',
      vocabulary: List<VocabularyModel>.from(
        (data['vocabulary'] as List<dynamic>).map((v) => VocabularyModel.fromMap(v)),
      ),
      dateCreate: (data['dateCreate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'creator': creator,
      'vocabulary': vocabulary.map((v) => v.toMap()).toList(),
      'dateCreate': Timestamp.fromDate(dateCreate),
    };
  }
}
