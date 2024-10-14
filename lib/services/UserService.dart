import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/UserModel.dart';

class UserService {
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('users');

  Future<UserModel?> getUserById(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await userCollection.doc(docId).get();
      if (docSnapshot.exists) {
        return UserModel.fromFirestore(docSnapshot);
      }
    } catch (e) {
      print('Error getting class: $e');
    }
    return null;
  }
}