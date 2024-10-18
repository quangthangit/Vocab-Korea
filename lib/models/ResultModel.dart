class ResultModel {
  String answerUser;
  String answer;
  String question;

  ResultModel({
    required this.answerUser,
    required this.answer,
    required this.question,
  });

  Map<String, dynamic> toMap() {
    return {
      'answerUser' : answerUser,
      'answer': answer,
      'question': question,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> data) {
    return ResultModel(
      answerUser : data['answerUser'] ?? '',
      answer: data['korean'] ?? '',
      question: data['vietnamese'] ?? '',
    );
  }
}