import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/MatchGameResultModel.dart';
import 'package:vocabkpop/models/UserCompletionTimesModel.dart';

class MatchGameResultService {
  final CollectionReference matchGameResultCollection = FirebaseFirestore.instance.collection('matchGameResult');

  Future<bool> createOrUpdateMatchGameResultModel(MatchGameResultModel matchGameResultModel) async {
    try {
      QuerySnapshot querySnapshot = await matchGameResultCollection
          .where('id_lesson', isEqualTo: matchGameResultModel.idLesson)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        MatchGameResultModel existingResult = MatchGameResultModel.fromFirestore(document);

        bool userExists = false;
        for (var userCompletion in existingResult.userCompletionTimesModel) {
          if (userCompletion.idUser == matchGameResultModel.userCompletionTimesModel.first.idUser) {
            if (matchGameResultModel.userCompletionTimesModel.first.userTimes < userCompletion.userTimes) {
              userCompletion.userTimes = matchGameResultModel.userCompletionTimesModel.first.userTimes;
            }
            userExists = true;
            break;
          }
        }

        if (!userExists) {
          existingResult.userCompletionTimesModel.add(matchGameResultModel.userCompletionTimesModel.first);
        }

        await matchGameResultCollection.doc(document.id).update(existingResult.toMap());
      } else {
        await matchGameResultCollection.add(matchGameResultModel.toMap());
      }

      return true;
    } catch (e) {
      print('Error creating/updating match game result: $e');
      return false;
    }
  }

  Future<List<UserCompletionTimesModel>> getTop10FastestUsers(String idLesson) async {
    try {
      QuerySnapshot querySnapshot = await matchGameResultCollection
          .where('id_lesson', isEqualTo: idLesson)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }
      DocumentSnapshot document = querySnapshot.docs.first;
      MatchGameResultModel matchGameResultModel = MatchGameResultModel.fromFirestore(document);
      List<UserCompletionTimesModel> sortedUsers = List.from(matchGameResultModel.userCompletionTimesModel)
        ..sort((a, b) => a.userTimes.compareTo(b.userTimes));
      return sortedUsers.take(10).toList();
    } catch (e) {
      print('Error fetching top 10 fastest users: $e');
      return [];
    }
  }
}
