import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/widget/bar/FlashCardBar.dart';

class QuizWidget extends StatefulWidget {
  final List<VocabularyModel> vocabularyModel;
  const QuizWidget({super.key, required this.vocabularyModel});
  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late List<VocabularyModel> _vocabularyList;
  late VocabularyModel _correctAnswer;
  late List<VocabularyModel> _options;
  late String _questionText;
  late String _title = 'Chọn câu trả lời';

  VocabularyModel? _selectedAnswer;
  bool? _isCorrect;
  Set<VocabularyModel> _usedWords = {};

  @override
  void initState() {
    super.initState();
    _vocabularyList = widget.vocabularyModel;
    _generateQuestion();
  }

  void _generateQuestion() {
    Random random = Random();

    if (_usedWords.length >= _vocabularyList.length) {
      _usedWords.clear();
    }

    do {
      _correctAnswer = _vocabularyList[random.nextInt(_vocabularyList.length)];
    } while (_usedWords.contains(_correctAnswer));

    _usedWords.add(_correctAnswer);
    _questionText = _correctAnswer.vietnamese;

    Set<VocabularyModel> optionsSet = {_correctAnswer};
    while (optionsSet.length < 4) {
      VocabularyModel randomOption = _vocabularyList[random.nextInt(_vocabularyList.length)];
      if (randomOption != _correctAnswer && !_usedWords.contains(randomOption)) {
        optionsSet.add(randomOption);
      }
    }
    _options = optionsSet.toList()..shuffle();
  }

  void _checkAnswer(VocabularyModel selectedAnswer) {
    setState(() {
      _selectedAnswer = selectedAnswer;
      _isCorrect = selectedAnswer == _correctAnswer;
      _title = _isCorrect! ? 'Bạn đang làm rất tuyệt !' : 'Chưa đúng hãy cố gắng nhé !';
    });

    if (_isCorrect == true) {
      Future.delayed(const Duration(seconds: 1), () {
        _nextQuestion();
      });
    }
  }

  void _nextQuestion() {
    setState(() {
      _selectedAnswer = null;
      _isCorrect = null;
      _title = 'Chọn câu trả lời';
      _generateQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FlashCardBar(currentIndex: 0, vocabularyList: _vocabularyList),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(_questionText, style: const TextStyle(fontSize: 30)),
                ),
                _selectedAnswer == null
                    ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(_title),
                )
                    : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _isCorrect == true
                      ? Text(
                    _title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  )
                      : Text(
                    _title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: _options.map((vocab) {
                      bool isSelected = _selectedAnswer == vocab;
                      bool isCorrectOption = vocab == _correctAnswer;
                      return GestureDetector(
                        onTap: () => _checkAnswer(vocab),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? (_isCorrect == true ? Colors.green : Colors.red)
                                  : (isCorrectOption && _isCorrect == false
                                  ? Colors.green
                                  : const Color(0xFFD9D9D9)),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              vocab.korean,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isCorrect == false
          ? Container(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _nextQuestion,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Câu tiếp theo',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      )
          : null,
    );
  }
}
