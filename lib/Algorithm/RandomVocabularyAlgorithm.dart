import 'dart:math';
import 'package:vocabkpop/models/VocabularyModel.dart';

class RandomVocabularyAlgorithm {
  void randomListVocabulary(List<VocabularyModel> vocabularyList) {
    vocabularyList.shuffle(Random());
  }
}
