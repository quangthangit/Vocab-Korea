import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vocabkpop/components/FlashCardWithAudio.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/widget/bar/FlashCardBar.dart';

class FlashCardPage extends StatefulWidget {
  final List<VocabularyModel> vocabularyModel;

  const FlashCardPage({super.key, required this.vocabularyModel});

  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  late PageController _pageController;
  late List<VocabularyModel> _vocabularyList;
  late FlutterTts _flutterTts;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _vocabularyList = widget.vocabularyModel;
    _pageController = PageController();
    _flutterTts = FlutterTts();

    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _speak(String text, String language) async {
    await _flutterTts.setLanguage(language);
    await _flutterTts.speak(text);
  }

  void _nextCard() {
    if (_currentIndex < _vocabularyList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (_currentIndex + 1) / _vocabularyList.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: FlashCardBar(
          currentIndex: _currentIndex,
          vocabularyList: _vocabularyList,
        ),
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
            child: PageView.builder(
              controller: _pageController,
              itemCount: _vocabularyList.length,
              itemBuilder: (context, index) {
                final vocabulary = _vocabularyList[index];
                return Center(
                  child: SizedBox(
                    width: 350,
                    child: FlipCard(
                      front: FlashCardWithAudio(
                        text: vocabulary.korean,
                        language: 'Tiếng Hàn',
                        onSpeak: () => _speak(vocabulary.korean, 'ko-KR'),
                      ),
                      back: FlashCardWithAudio(
                        text: vocabulary.vietnamese,
                        language: 'Tiếng Việt',
                        onSpeak: () => _speak(vocabulary.vietnamese, 'vi-VN'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 30, color: Colors.grey),
                  onPressed: _previousCard,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 30, color: Colors.grey),
                  onPressed: _nextCard,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
