import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  String name;
  String description;
  int numberCollection;
  String password;
  DateTime createdAt;
  String idUser;
  int allowEdit;
  List<String> idMember;

  ClassModel({
    required this.name,
    required this.description,
    required this.numberCollection,
    required this.password,
    required this.createdAt,
    required this.idUser,
    required this.allowEdit,
    required this.idMember,
  });

  factory ClassModel.fromFirestore(Map<String, dynamic> data) {
    return ClassModel(
      name: data['name'],
      numberCollection: data['number_collection'],
      password: data['password'],
      description: data['description'],
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
