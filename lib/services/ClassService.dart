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
        return ClassModel.fromFirestore(docSnapshot.data() as Map<String, dynamic>);
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
        return ClassModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print('Error getting classes: $e');
      return [];
    }
  }

  Future<List<ClassModel>> getClassesExcludingUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await classCollection.get();
      print('Number of documents retrieved: ${querySnapshot.docs.length}');

      List<ClassModel> classes = querySnapshot.docs.map((doc) {
        print('Document ID: ${doc.id}');
        print('Document data: ${doc.data()}');
        return ClassModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      print('Classes before filtering: ${classes.map((classModel) => classModel.name).toList()}');

      if (userId.isEmpty) {
        print('Provided userId is empty. Returning all classes.');
        return classes;
      }

      List<ClassModel> filteredClasses = classes.where((classModel) {
        bool isIncluded = classModel.idMember.contains(userId);
        print('Checking class: ${classModel.name}, userId: $userId, isIncluded: $isIncluded');
        return isIncluded;
      }).toList();

      print('Classes after filtering: ${filteredClasses.map((classModel) => classModel.name).toList()}');

      return filteredClasses;
    } catch (e) {
      print('Error getting classes: $e');
      return [];
    }
  }

}
