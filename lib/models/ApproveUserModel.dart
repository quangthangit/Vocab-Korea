class ApproveUserModel {
  final String uId;
  final String urlAvt;

  ApproveUserModel({
    required this.uId,
    required this.urlAvt,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': uId,
      'url_avatar': urlAvt,
    };
  }

  factory ApproveUserModel.fromMap(Map<String, dynamic> data) {
    return ApproveUserModel(
      uId: data['user_id'] ?? '',
      urlAvt: data['url_avatar'] ?? '',
    );
  }
}
