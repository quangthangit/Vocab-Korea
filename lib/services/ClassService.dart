import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/ClassModel.dart';

class ClassService {
  final CollectionReference classCollection = FirebaseFirestore.instance.collection('class');

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

  Future<bool> updateClass(String docId, ClassModel classModel) async {
    try {
      await classCollection.doc(docId).update(classModel.toMap());
      return true;
    } catch (e) {
      print('Error updating class: $e');
      return false;
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

  Future<List<ClassModel>> searchClass(String value) async {
    List<ClassModel> classList = [];
    String lowercaseValue = value.toLowerCase();
    try {
      QuerySnapshot querySnapshot = await classCollection.get();

      for (var doc in querySnapshot.docs) {
        ClassModel classModel = ClassModel.fromFirestore(doc);

        String nameLowercase = classModel.name.toLowerCase();
        String descriptionLowercase = classModel.description.toLowerCase();

        if (nameLowercase.contains(lowercaseValue) || descriptionLowercase.contains(lowercaseValue)) {
          classList.add(classModel);
        }
      }
    } catch (e) {
      print('Error searching for class: $e');
    }
    return classList;
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

  Future<bool> checkExistUser(String classId, String userId) async {
    try {
      DocumentSnapshot docSnapshot = await classCollection.doc(classId).get();
      if (docSnapshot.exists) {
        ClassModel classModel = ClassModel.fromFirestore(docSnapshot);
        return classModel.idMember.contains(userId);
      }
    } catch (e) {
      print('Error checking user existence in class: $e');
    }
    return false;
  }
}
