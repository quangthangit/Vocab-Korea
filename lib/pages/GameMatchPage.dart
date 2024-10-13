import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'dart:math';
import 'dart:async';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/widget/bar/GameMatchBar.dart';

class GameMatchPage extends StatefulWidget {
  final List<VocabularyModel> vocabularyModel;
  const GameMatchPage({super.key, required this.vocabularyModel});

  @override
  _GameMatchState createState() => _GameMatchState();
}

class _GameMatchState extends State<GameMatchPage> with SingleTickerProviderStateMixin {
  late List<String> _listVocabulary;
  late List<bool> _selectedIndices, _isCorrect;
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  late List<VocabularyModel> _vocabularyList;
  int _numberDone = 0;
  double _seconds = 0.0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _vocabularyList = widget.vocabularyModel;
    _listVocabulary = _generateVocabularyList(_vocabularyList);
    _startTimer();

    _selectedIndices = List.filled(_listVocabulary.length, false);
    _isCorrect = List.filled(_listVocabulary.length, false);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _isRunning = true;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isRunning) {
        setState(() => _seconds += 0.1);
      } else {
        timer.cancel();
      }
    });
  }

  void _stopTimer() => setState(() => _isRunning = false);

  void _onCardTap(int index) {
    setState(() {
      int selectedCount = _selectedIndices.where((isSelected) => isSelected).length;

      _selectedIndices[index] = !_selectedIndices[index];
      if (selectedCount == 1) {
        List<int> selectedIndices = _selectedIndices
            .asMap()
            .entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();

        if (selectedIndices.length == 2) {
          bool isCorrect = _checkPair(_listVocabulary[selectedIndices[0]], _listVocabulary[selectedIndices[1]]);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isCorrect ? "Correct!" : "Try Again!"),
              duration: const Duration(seconds: 1),
            ),
          );

          if (isCorrect) {
            _markCorrect(selectedIndices);
          } else {
            _animateShake();
          }
          _selectedIndices.fillRange(0, _selectedIndices.length, false);
        }
      }
    });
  }

  void _markCorrect(List<int> selectedIndices) {
    setState(() {
      _isCorrect[selectedIndices[0]] = true;
      _isCorrect[selectedIndices[1]] = true;
      _listVocabulary[selectedIndices[0]] = "";
      _listVocabulary[selectedIndices[1]] = "";
      _numberDone++;

      if (_numberDone == 6) {
        _stopTimer();
        _showCompletionMessage();
      }
    });
  }

  void _animateShake() {
    _controller.forward().then((_) => _controller.reverse());
  }

  bool _checkPair(String a, String b) {
    return _vocabularyList.any((entry) => (entry.korean == a && entry.vietnamese == b) || (entry.korean == b && entry.vietnamese == a));
  }

  List<String> _generateVocabularyList(List<VocabularyModel> vocabularyList) {
    List<VocabularyModel> selectedWords = (vocabularyList.length > 6)
        ? (vocabularyList..shuffle()).take(6).toList()
        : vocabularyList;

    List<String> koreanWords = selectedWords.map((item) => item.korean).toList();
    List<String> vietnameseWords = selectedWords.map((item) => item.vietnamese).toList();

    return koreanWords + vietnameseWords;
  }

  void _showCompletionMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Completed!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text("You completed the game in ${_seconds.toStringAsFixed(1)} seconds.", style: const TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              child: const Text("Finish", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = _numberDone / 6;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: GameMatchBar(seconds: _seconds),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFD7DEE5),
            color: AppColors.iconColor,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              itemCount: _listVocabulary.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 120 / 150,
              ),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    if (_listVocabulary[index].isNotEmpty) {
                      return Transform.translate(
                        offset: _isCorrect[index]
                            ? Offset.zero
                            : Offset(_shakeAnimation.value * (index % 2 == 0 ? 1 : -1), 0),
                        child: GestureDetector(
                          onTap: () => _onCardTap(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Card(
                              color: _selectedIndices[index] ? const Color(0xFFBFC4FC) : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: AppColors.iconColor, width: 1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  _listVocabulary[index],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
