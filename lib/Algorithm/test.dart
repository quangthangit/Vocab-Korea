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

void main() {
  String word1 = "인사하다 ";
  String word2 = "사랑하다 ";

  double sim = similarity(word1, word2);
  print('Độ tương tự giữa "$word1" và "$word2": $sim');
}
