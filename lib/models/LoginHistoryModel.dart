import 'package:cloud_firestore/cloud_firestore.dart';

class LoginHistoryModel {
  String id;
  String idUser;
  List<DateTime> listDateTime;

  LoginHistoryModel({
    this.id = '',
    required this.idUser,
    required this.listDateTime,
  });

  factory LoginHistoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LoginHistoryModel(
      id: doc.id,
      idUser: data['idUser'],
      listDateTime: (data['listDateTime'] as List<dynamic>)
          .map((timestamp) => (timestamp as Timestamp).toDate())
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'listDateTime': listDateTime.map((date) => Timestamp.fromDate(date)).toList(),
    };
  }
}
