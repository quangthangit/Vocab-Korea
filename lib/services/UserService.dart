import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/UserModel.dart';

class UserService {
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('users');

  Future<bool> createUser(UserModel userModel) async {
    try {
      await userCollection.add(userModel.toMap());
      return true;
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
  }

  Future<UserModel?> getUserById(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await userCollection.doc(docId).get();
      if (docSnapshot.exists) {
        return UserModel.fromFirestore(docSnapshot);
      }
    } catch (e) {
      print('Error getting user: $e');
    }
    return null;
  }

  Future<bool> updateUserName(String userId, String userName) async {
    try {
      UserModel? user = await getUserById(userId);
      if(user!=null) {
        user.username = userName;
        await userCollection.doc(userId).update(user.toMap());
        return true;
      }
      else {
        return false;
      }

    } catch (e) {
      print('Error updating class: $e');
      return false;
    }
  }

}