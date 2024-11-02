import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';

class LessonModel {
  String id;
  String title;
  String description;
  String creator;
  String imageUser;
  List<VocabularyModel> vocabulary;
  DateTime dateCreate;
  List<String> idMember;

  LessonModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.creator,
    required this.imageUser,
    required this.vocabulary,
    required this.dateCreate,
    required this.idMember,
  });

  factory LessonModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LessonModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      creator: data['creator'] ?? '',
      imageUser : data['imageUser'],
      vocabulary: List<VocabularyModel>.from(
        (data['vocabulary'] as List<dynamic>).map((v) => VocabularyModel.fromMap(v)),
      ),
      dateCreate: (data['dateCreate'] as Timestamp).toDate(),
      idMember: List<String>.from(data['idMember'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'creator': creator,
      'imageUser' : imageUser,
      'vocabulary': vocabulary.map((v) => v.toMap()).toList(),
      'dateCreate': Timestamp.fromDate(dateCreate),
      'idMember' : idMember
    };
  }
  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'],
      dateCreate: map['creator'],
      vocabulary: List<VocabularyModel>.from(
        (map['vocabulary'] as List<dynamic>).map((v) => VocabularyModel.fromMap(v)),
      ),
      imageUser : map['imageUser'],
      creator: map['creator'],
      title: map['title'],
      description: map['description'],
      idMember: map['idMember'],
    );
  }

}
