import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/ClassModel.dart';

class ClassService {
  final CollectionReference classCollection = FirebaseFirestore.instance.collection('classes');

  Future<bool> createClass(ClassModel classModel) async {
    try {
      await classCollection.add(classModel.toMap());
      return true;
    } catch (e) {
      print('Error creating class: $e');
      return false;
    }
  }

  Future<ClassModel?> getClassById(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await classCollection.doc(docId).get();
      if (docSnapshot.exists) {
        return ClassModel.fromFirestore(docSnapshot);
      }
    } catch (e) {
      print('Error getting class: $e');
    }
    return null;
  }

  Future<void> updateClass(String docId, ClassModel classModel) async {
    try {
      await classCollection.doc(docId).update(classModel.toMap());
    } catch (e) {
      print('Error updating class: $e');
    }
  }

  Future<void> deleteClass(String docId) async {
    try {
      await classCollection.doc(docId).delete();
    } catch (e) {
      print('Error deleting class: $e');
    }
  }

  Future<List<ClassModel>> getAllClasses() async {
    try {
      QuerySnapshot querySnapshot = await classCollection.get();
      return querySnapshot.docs.map((doc) {
        return ClassModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error getting classes: $e');
      return [];
    }
  }

  Future<List<ClassModel>> getClassesExcludingUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await classCollection
          .where('idMember', arrayContains: userId)
          .get();

      List<ClassModel> classes = querySnapshot.docs.map((doc) {
        return ClassModel.fromFirestore(doc);
      }).toList();

      return classes;
    } catch (e) {
      print('Error getting classes: $e');
      return [];
    }
  }
}
