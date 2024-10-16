class UserCompletionTimesModel {
  String idUser;
  double userTimes;

  UserCompletionTimesModel({
    required this.idUser,
    required this.userTimes,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'userTimes': userTimes,
    };
  }

  factory UserCompletionTimesModel.fromMap(Map<String, dynamic> data) {
    return UserCompletionTimesModel(
      idUser: data['idUser'] ?? '',
      userTimes: data['userTimes'] ?? '',
    );
  }
}
