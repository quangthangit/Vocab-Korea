import 'package:vocabkpop/models/VocabularyModel.dart';

class Levenshtein {
  int levenshtein(String a, String b) {
    var d = List.generate(a.length + 1, (i) => List.filled(b.length + 1, 0));
    for (var i = 0; i <= a.length; i++) {
      d[i][0] = i;
    }
    for (var j = 0; j <= b.length; j++) {
      d[0][j] = j;
    }
    for (var i = 1; i <= a.length; i++) {
      for (var j = 1; j <= b.length; j++) {
        var cost = (a[i - 1] == b[j - 1]) ? 0 : 1;
        d[i][j] = [
          d[i - 1][j] + 1,
          d[i][j - 1] + 1,
          d[i - 1][j - 1] + cost
        ].reduce((value, element) => value < element ? value : element);
      }
    }
    return d[a.length][b.length];
  }

  double similarity(String a, String b) {
    if (a.isEmpty && b.isEmpty) return 1.0;
    if (a.isEmpty || b.isEmpty) return 0.0;
    var distance = levenshtein(a, b);
    return 1 - distance / (a.length > b.length ? a.length : b.length);
  }
  List<VocabularyModel> selectQuestion(int language, String keyWord, List<VocabularyModel> list) {
    List<VocabularyModel> filteredList = list.where((vocab) {
      return language == 0 ? keyWord != vocab.korean : keyWord != vocab.vietnamese;
    }).toList();

    List<Map<String, dynamic>> similarityList = filteredList.map((vocab) {
      return {
        'vocab': vocab,
        'similarity': similarity(keyWord, language == 0 ? vocab.korean : vocab.vietnamese)
      };
    }).toList();
    similarityList.sort((a, b) => b['similarity'].compareTo(a['similarity']));
    return similarityList.take(3).map((e) => e['vocab'] as VocabularyModel).toList();
  }
}