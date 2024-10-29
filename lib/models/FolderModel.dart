import 'package:cloud_firestore/cloud_firestore.dart';

class FolderModel {
  final String id;
  final String title;
  List<String> lessonList;
  final DateTime createdAt;
  final String idUser;
  List<String> idMember;

  FolderModel( {
    this.id = '',
    required this.title,
    required this.lessonList,
    required this.createdAt,
    required this.idUser,
    required this.idMember,
  });

  factory FolderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FolderModel(
      id: doc.id,
      title: data['title'],
      lessonList: List<String>.from(data['lesson_list']),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      idUser: data['idUser'],
      idMember: List<String>.from(data['idMember'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'created_at': Timestamp.fromDate(createdAt),
      'lesson_list': lessonList,
      'idUser' : idUser,
      'idMember': idMember,
    };
  }

}