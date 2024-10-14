import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/FolderModel.dart';

class FolderService {
  final CollectionReference folderCollection = FirebaseFirestore.instance.collection('folder');

  Future<Map<String, dynamic>> createFolder(FolderModel folderModel) async {
    try {
      DocumentReference docRef = await folderCollection.add(folderModel.toMap());
      return{
        'success': true,
        'id' : docRef.id
      };
    } catch (e) {
      print('Error creating class: $e');
      return {
        'success': false,
        'id' : null
      };
    }
  }

  Future<FolderModel?> getFolderById(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await folderCollection.doc(docId).get();
      if (docSnapshot.exists) {
        return FolderModel.fromFirestore(docSnapshot);
      }
    } catch (e) {
      print('Error getting class: $e');
    }
    return null;
  }

  Future<void> updateFolder(String docId, FolderModel folderModel) async {
    try {
      await folderCollection.doc(docId).update(folderModel.toMap());
    } catch (e) {
      print('Error updating class: $e');
    }
  }

  Future<void> deleteFolder(String docId) async {
    try {
      await folderCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting class: $e');
    }
  }

  Future<List<FolderModel>> getAllFolder() async {
    try {
      QuerySnapshot querySnapshot = await folderCollection.get();
      return querySnapshot.docs.map((doc) {
        return FolderModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error getting classes: $e');
      return [];
    }
  }

}