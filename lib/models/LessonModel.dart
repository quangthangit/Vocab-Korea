import 'package:vocabkpop/models/VocabularyModel.dart';

class LessonModel {
  final String title;
  final String description;
  final String creator;
  final List<VocabularyModel> vocabulary;
  final String dateCreate;

  LessonModel({
    required this.title,
    required this.description,
    required this.creator,
    required this.vocabulary,
    required this.dateCreate,
  });
}