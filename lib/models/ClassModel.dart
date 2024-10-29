import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/ApproveUserModel.dart';

class ClassModel {
  String id;
  String name;
  String description;
  List<String> idFolder;
  int status;
  DateTime createdAt;
  String idUser;
  String imageUser;
  int allowEdit;
  List<String> idMember;
  List<ApproveUserModel> listApprove;


  ClassModel({
    this.id = '',
    required this.name,
    required this.description,
    required this.idFolder,
    required this.status,
    required this.createdAt,
    required this.idUser,
    required this.imageUser,
    required this.allowEdit,
    required this.idMember,
    required this.listApprove,
  });

  factory ClassModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ClassModel(
      id: doc.id,
      name: data['name'],
      description: data['description'],
      idFolder: List<String>.from(data['id_folder']),
      status: data['status'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
      idUser: data['id_user'],
      imageUser : data['imageUser'],
      allowEdit: data['allow_edit'],
      idMember: List<String>.from(data['idMember'] ?? []),
      listApprove: List<ApproveUserModel>.from(
        (data['listApprove'] as List<dynamic>).map((v) => ApproveUserModel.fromMap(v)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'id_folder': idFolder,
      'status': status,
      'created_at': createdAt,
      'id_user': idUser,
      'imageUser' : imageUser,
      'allow_edit': allowEdit,
      'idMember': idMember,
      'listApprove': listApprove.map((v) => v.toMap()).toList(),
    };
  }
}