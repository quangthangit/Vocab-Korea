import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'dart:math';
import 'dart:async';
import 'package:vocabkpop/data_test/vocabulary_data.dart';
import 'package:vocabkpop/models/Vocabulary.dart';
import 'package:vocabkpop/widget/bar/GameMatchBar.dart';

class GameMatchPage extends StatefulWidget {
  @override
  _GameMatchState createState() => _GameMatchState();
}

class _GameMatchState extends State<GameMatchPage> with SingleTickerProviderStateMixin {
  late List<String> _listVocabulary;
  late List<bool> _selectedIndices;
  late List<bool> _isCorrect;
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  late List<Vocabulary> _vocabularyList;
  int numberDone = 0;
  double _seconds = 0.0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _vocabularyList = vocabularyList;
    _listVocabulary = _handleList(_vocabularyList);
    _startTimer();

    _selectedIndices = List.generate(_listVocabulary.length, (index) => false);
    _isCorrect = List.generate(_listVocabulary.length, (index) => false);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  void _startTimer() {
    _isRunning = true;
    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      if (_isRunning) {
        setState(() {
          _seconds += 0.1;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCardTap(int index) {
    setState(() {
      int selectedCount = _selectedIndices.where((isSelected) => isSelected).length;

      if (_selectedIndices[index]) {
        _selectedIndices[index] = false;
      } else if (selectedCount < 2) {
        _selectedIndices[index] = true;
      }

      if (selectedCount == 1) {
        List<int> numberSelected = _checkNumberSelected(_selectedIndices);
        if (numberSelected.length == 2) {
          bool isCorrect = _checkMeaning(
            _listVocabulary[numberSelected[0]],
            _listVocabulary[numberSelected[1]],
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isCorrect ? "Correct!" : "Try Again!"),
              duration: Duration(seconds: 1),
            ),
          );

          if (!isCorrect) {
            _controller.forward().then((value) {
              _controller.reverse();
            });

            _isCorrect[numberSelected[0]] = false;
            _isCorrect[numberSelected[1]] = false;
          } else {
            _isCorrect[numberSelected[0]] = true;
            _isCorrect[numberSelected[1]] = true;

            _listVocabulary[numberSelected[0]] = "";
            _listVocabulary[numberSelected[1]] = "";

            numberDone += 1;

            if (numberDone == 6) {
              _stopTimer();
              _showCompletionMessage();
            }
          }
          _selectedIndices.fillRange(0, _selectedIndices.length, false);
        }
      }
    });
  }

  void _showCompletionMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Completed!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          content: Text("You completed the game in ${_seconds.toStringAsFixed(1)} seconds.", style: const TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              child: const Text("Finish", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<int> _checkNumberSelected(List<bool> selectedIndices) {
    return selectedIndices.asMap().entries.where((entry) => entry.value).map((entry) => entry.key).toList();
  }

  bool _checkMeaning(String a, String b) {
    for (var entry in _vocabularyList) {
      if ((entry.korean == a && entry.vietnamese == b) ||
          (entry.korean == b && entry.vietnamese == a)) {
        return true;
      }
    }
    return false;
  }

  List<String> _handleList(List<Vocabulary> vocabularyList) {
    List<Vocabulary> selectedWords;
    if (vocabularyList.length > 6) {
      vocabularyList.shuffle(Random());
      selectedWords = vocabularyList.take(6).toList();
    } else {
      selectedWords = vocabularyList;
    }
    List<String> koreanWords = selectedWords.map((item) => item.korean).toList();
    List<String> vietnameseWords = selectedWords.map((item) => item.vietnamese).toList();
    return koreanWords + vietnameseWords;
  }

  @override
  Widget build(BuildContext context) {
    double progress = numberDone / 6;
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
                crossAxisCount: 3, // Number of columns
                childAspectRatio: 120 / 150,
              ),
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    if (_listVocabulary[index] != "") {
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
                    } else {
                      return Container();
                    }
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
