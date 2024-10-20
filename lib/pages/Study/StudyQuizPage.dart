import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vocabkpop/Algorithm/Levenshtein.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/widget/bar/FlashCardBar.dart';
import 'package:vocabkpop/app_colors.dart' as AppColor;
import 'package:vocabkpop/widget/bar/StudyEssayBar.dart';

class QuizWidget extends StatefulWidget {
  final List<VocabularyModel> vocabularyModel;
  final int language;
  const QuizWidget({super.key, required this.vocabularyModel, required this.language});

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late List<VocabularyModel> _vocabularyList;
  late String _title = 'Chọn câu trả lời';
  late PageController _pageController;
  VocabularyModel? _selectedAnswer;
  bool? _isCorrect;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _vocabularyList = widget.vocabularyModel;
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  void _checkAnswer(VocabularyModel selectedAnswer, VocabularyModel correctAnswer) {
    if (_selectedAnswer != null) return;

    setState(() {
      _selectedAnswer = selectedAnswer;
      _isCorrect = selectedAnswer == correctAnswer;
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
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final double progress = (_currentIndex + 1) / _vocabularyList.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: StudyEssayBar(
            currentIndex: _currentIndex,
            vocabularyList: _vocabularyList),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Color(0xFFD7DEE5),
              color: AppColor.AppColors.iconColor,
            ),
            Expanded(
              child: PageView.builder(
                itemCount: _vocabularyList.length,
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) {
                  final vocabulary = _vocabularyList[index];
                  final VocabularyModel correctAnswer = vocabulary;

                  // Generate options for the current question
                  List<VocabularyModel> optionsSet = [correctAnswer];
                  optionsSet.addAll(Levenshtein().selectQuestion(
                    widget.language,
                    widget.language == 0 ? correctAnswer.korean : correctAnswer.vietnamese,
                    _vocabularyList,
                  ));

                  // No need to shuffle since we want them in order
                  final List<VocabularyModel> options = optionsSet.toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          widget.language == 0 ? vocabulary.vietnamese : vocabulary.korean,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          _selectedAnswer == null ? _title : (_isCorrect == true ? _title : _title),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: _isCorrect == true ? Colors.green : (_selectedAnswer != null ? Colors.red : Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: options.map((vocab) {
                            bool isSelected = _selectedAnswer == vocab;
                            bool isCorrectOption = vocab == correctAnswer;

                            return GestureDetector(
                              onTap: () => _checkAnswer(vocab, correctAnswer),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? (_isCorrect == true ? Colors.green : Colors.red)
                                        : (isCorrectOption && _isCorrect == false ? Colors.green : const Color(0xFFD9D9D9)),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(vertical: 30),
                                child: Center(
                                  child: Text(
                                    widget.language == 0 ? vocab.korean : vocab.vietnamese,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _isCorrect == false
          ? Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 120),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _nextQuestion,
          child: const Text(
            'Câu tiếp theo',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      )
          : null,
    );
  }
}
