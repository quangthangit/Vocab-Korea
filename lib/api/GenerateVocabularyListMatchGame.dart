import 'package:vocabkpop/models/VocabularyModel.dart';

class GenerateVocabularyGameMatch {
  List<String> generateVocabularyList(List<VocabularyModel> vocabularyList,int numberTag) {
    List<VocabularyModel> selectedWords = (vocabularyList.length > 6)
        ? (vocabularyList..shuffle()).take(numberTag).toList()
        : vocabularyList;
    List<String> koreanWords = selectedWords.map((item) => item.korean).toList();
    List<String> vietnameseWords = selectedWords.map((item) => item.vietnamese).toList();

    List<String> combinedWords = [...koreanWords, ...vietnameseWords]..shuffle();
    return combinedWords;
  } 
}