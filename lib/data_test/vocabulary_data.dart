import 'package:intl/intl.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';

List<VocabularyModel> vocabularyList = [
  // VocabularyModel(1, korean: '사람', vietnamese: 'Người'),
  // VocabularyModel(0, korean: '학교', vietnamese: 'Trường học'),
  // VocabularyModel(1, korean: '사랑', vietnamese: 'Tình yêu'),
  // VocabularyModel(0, korean: '친구', vietnamese: 'Bạn bè'),
  // VocabularyModel(1, korean: '가족', vietnamese: 'Gia đình'),
  // VocabularyModel(1, korean: '사랑하다', vietnamese: 'Yêu'),
  // VocabularyModel(0, korean: '음식', vietnamese: 'Thức ăn'),
  // VocabularyModel(1, korean: '행복', vietnamese: 'Hạnh phúc'),
];


List<VocabularyModel> vocabularyList2 = [
  // VocabularyModel(1, korean: '1사람', vietnamese: 'Người'),
  // VocabularyModel(0, korean: '2학교', vietnamese: 'Trường học'),
  // VocabularyModel(1, korean: '3사랑', vietnamese: 'Tình yêu'),
  // VocabularyModel(0, korean: '4친구', vietnamese: 'Bạn bè'),
];

DateTime dateCreate = DateTime(2003, 12, 4);
String formattedDate = DateFormat('yyyy/MM/dd').format(dateCreate);

LessonModel sampleLesson = LessonModel(
  title: 'Bài học từ vựng tiếng Hàn',
  description: 'Khám phá những từ vựng cơ bản trong tiếng Hàn.',
  creator: 'Giáo viên A',
  dateCreate: DateTime.now(),
  vocabulary: vocabularyList,
);

List<LessonModel> listLesson = [
  LessonModel(
    title: 'Bài học từ vựng tiếng Hàn',
    description: 'Khám phá những từ vựng cơ bản trong tiếng Hàn.',
    creator: 'Giáo viên A',
    dateCreate: DateTime.now(),
    vocabulary: vocabularyList,
  ),
  LessonModel(
    title: 'Bài học từ vựng tiếng Hàn',
    description: 'Khám phá những từ vựng cơ bản trong tiếng Hàn.',
    creator: 'Giáo viên A',
    dateCreate: DateTime.now(),
    vocabulary: vocabularyList2,
  ),
];