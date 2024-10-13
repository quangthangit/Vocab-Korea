import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  String id;
  String name;
  String description;
  int numberCollection;
  String password;
  DateTime createdAt;
  String idUser;
  int allowEdit;
  List<String> idMember;


  ClassModel({
    this.id = '',
    required this.name,
    required this.description,
    required this.numberCollection,
    required this.password,
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
      numberCollection: data['number_collection'],
      password: data['password'],
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
      'number_collection': numberCollection,
      'password': password,
      'created_at': createdAt,
      'id_user': idUser,
      'allow_edit': allowEdit,
      'idMember': idMember,
    };
  }
}
