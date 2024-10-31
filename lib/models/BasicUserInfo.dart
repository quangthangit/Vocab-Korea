class BasicUserInfo  {
  final String idUser;
  final String urlAvt;

  BasicUserInfo ({
    required this.idUser,
    required this.urlAvt,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'urlAvt': urlAvt,
    };
  }

  factory BasicUserInfo .fromMap(Map<String, dynamic> data) {
    return BasicUserInfo (
      idUser: data['idUser'] ?? '',
      urlAvt: data['urlAvt'] ?? '',
    );
  }
}
