import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/UserCompletionTimesModel.dart';

class MatchGameResultModel {
  String id;
  String idLesson;
  DateTime createdAt;
  List<UserCompletionTimesModel> userCompletionTimesModel;

  MatchGameResultModel({
    this.id = '',
    required this.idLesson,
    required this.createdAt,
    required this.userCompletionTimesModel,
  });

  factory MatchGameResultModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MatchGameResultModel(
      id: doc.id,
      idLesson: data['id_lesson'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
      userCompletionTimesModel: List<UserCompletionTimesModel>.from(
        (data['userCompletionTimesModel'] as List<dynamic>).map((v) => UserCompletionTimesModel.fromMap(v)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_lesson': idLesson,
      'created_at': createdAt,
      'userCompletionTimesModel': userCompletionTimesModel.map((v) => v.toMap()).toList(),
    };
  }
}
