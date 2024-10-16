import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  String id;
  String name;
  String description;
  List<String> idFolder;
  int key;
  DateTime createdAt;
  String idUser;
  int allowEdit;
  List<String> idMember;


  ClassModel({
    this.id = '',
    required this.name,
    required this.description,
    required this.idFolder,
    required this.key,
    required this.createdAt,
    required this.idUser,
    required this.allowEdit,
    required this.idMember,
  });

  factory ClassModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ClassModel(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      idFolder: List<String>.from(data['id_folder']),
      key: data['key'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
      idUser: data['id_user'],
      allowEdit: data['allow_edit'],
      idMember: List<String>.from(data['idMember'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'id_folder': idFolder,
      'key': key,
      'created_at': createdAt,
      'id_user': idUser,
      'allow_edit': allowEdit,
      'idMember': idMember,
    };
  }
}