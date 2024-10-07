import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vocabkpop/models/Vocabulary.dart';
import 'package:vocabkpop/data_test/vocabulary_data.dart';
import 'package:vocabkpop/widget/StudyBar.dart';

class QuizWidget extends StatefulWidget {
  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late List<Vocabulary> _vocabularyList;
  late Vocabulary _correctAnswer;
  late List<Vocabulary> _options;
  late String _questionText;
  late String _title = 'Chọn câu trả lời';

  Vocabulary? _selectedAnswer;
  bool? _isCorrect;
  Set<Vocabulary> _usedWords = {};

  @override
  void initState() {
    super.initState();
    _vocabularyList = vocabularyList;
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

    Set<Vocabulary> optionsSet = {_correctAnswer};

    while (optionsSet.length < 4) {
      Vocabulary randomOption = _vocabularyList[random.nextInt(_vocabularyList.length)];
      if (randomOption != _correctAnswer && !_usedWords.contains(randomOption)) {
        optionsSet.add(randomOption);
      }
    }

    _options = optionsSet.toList()..shuffle();
  }

  void _checkAnswer(Vocabulary selectedAnswer) {
    setState(() {
      _selectedAnswer = selectedAnswer;
      _isCorrect = selectedAnswer == _correctAnswer;
      _title = _isCorrect! ? 'Bạn đang làm rất tuyệt !' : 'Chưa đúng hãy cố gắng nhé !';
    });

    if (_isCorrect == true) {
      Future.delayed(Duration(seconds: 1), () {
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
    return ListView(
      children: [
        StudyBar(),
        Container(
          padding: EdgeInsets.all(20),
          child: Text(_questionText, style: TextStyle(fontSize: 30)),
        ),
        _selectedAnswer == null
            ? Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(_title),
        )
            : Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _isCorrect == true
              ? Text(_title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.green))
              : Text(_title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red)),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
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
                          : (isCorrectOption && _isCorrect == false ? Colors.green : Color(0xFFD9D9D9)),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(child: Text(vocab.korean, style: TextStyle(fontSize: 15))),
                ),
              );
            }).toList(),
          ),
        ),
        if (_isCorrect == false)
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _nextQuestion,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Câu tiếp theo',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}