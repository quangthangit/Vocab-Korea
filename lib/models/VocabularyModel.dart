class VocabularyModel {
  final String korean;
  final String vietnamese;
  final int star;

  VocabularyModel({
    required this.korean,
    required this.vietnamese,
    required this.star,
  });

  Map<String, dynamic> toMap() {
    return {
      'korean': korean,
      'vietnamese': vietnamese,
      'star': star,
    };
  }

  factory VocabularyModel.fromMap(Map<String, dynamic> data) {
    return VocabularyModel(
      korean: data['korean'] ?? '',
      vietnamese: data['vietnamese'] ?? '',
      star: data['star'] ?? 0,
    );
  }
}
