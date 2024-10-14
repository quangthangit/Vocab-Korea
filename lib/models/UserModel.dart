import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String username;
  String email;
  String passwordHash;
  DateTime createdAt;
  DateTime lastLogin;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.createdAt,
    required this.lastLogin,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      username: data['username'],
      email: data['email'],
      passwordHash: data['password_hash'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
      lastLogin: (data['last_login'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'password_hash': passwordHash,
      'created_at': createdAt,
      'last_login': lastLogin,
    };
  }
}