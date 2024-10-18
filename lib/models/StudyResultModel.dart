import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/ResultModel.dart';

class StudyResultModel {
  String id;
  String idUser;
  int totalQuestions;
  int correctAnswers;
  int wrongAnswers;
  DateTime dateStudy;
  int timeTaken;
  List<ResultModel> listResultModel;

  StudyResultModel({
    this.id = '',
    required this.idUser,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.dateStudy,
    required this.timeTaken,
    required this.listResultModel
  });

  factory StudyResultModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StudyResultModel(
      id: doc.id,
      idUser: data['idUser'] ?? '',
      totalQuestions: data['totalQuestions'] ?? 0,
      correctAnswers: data['correctAnswers'] ?? 0,
      wrongAnswers: data['wrongAnswers'] ?? 0,
      dateStudy: (data['dateStudy'] as Timestamp).toDate(),
      timeTaken: data['timeTaken'] ?? 0,
      listResultModel: List<ResultModel>.from(
        (data['listResultModel'] as List<dynamic>).map((v) => ResultModel.fromMap(v)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'dateStudy': Timestamp.fromDate(dateStudy),
      'timeTaken': timeTaken,
      'listResultModel': listResultModel.map((v) => v.toMap()).toList(),
    };
  }
}
