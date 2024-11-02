import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/LoginHistoryModel.dart';

class LoginHistoryService {
  final CollectionReference loginHistoryCollection = FirebaseFirestore.instance.collection('loginHistory');

  Future<bool> createLoginHistory(LoginHistoryModel loginHistoryModel) async {
    try {
      await loginHistoryCollection.add(loginHistoryModel.toMap());
      return true;
    } catch (e) {
      print('Error creating login history: $e');
      return false;
    }
  }

  Future<LoginHistoryModel?> getLoginHistoryModelByUser(String userId) async {
    try {
      QuerySnapshot querySnapshot = await loginHistoryCollection
          .where('idUser', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return LoginHistoryModel.fromFirestore(querySnapshot.docs.first);
      }
      return null;
    } catch (e) {
      print('Error getting login history: $e');
      return null;
    }
  }

  Future<bool> updateLoginHistory(String docId, LoginHistoryModel loginHistoryModel) async {
    try {
      await loginHistoryCollection.doc(docId).update(loginHistoryModel.toMap());
      return true;
    } catch (e) {
      print('Error updating class: $e');
      return false;
    }
  }
}
