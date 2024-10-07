import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vocabkpop/components/FlashCardWithAudio.dart';
import 'package:vocabkpop/data_test/vocabulary_data.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/widget/bar/FlashCardBar.dart';

class FlashCardPage extends StatefulWidget {
  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  late PageController _pageController;
  late List<VocabularyModel> _vocabularyList;
  late FlutterTts flutterTts;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _vocabularyList = vocabularyList;
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page!.round();
      });
    });

    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _speak(String text, String language) async {
    await flutterTts.setLanguage(language);
    await flutterTts.speak(text);
  }

  void _nextCard() {
    if (currentIndex < _vocabularyList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousCard() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / _vocabularyList.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: FlashCardBar(currentIndex: currentIndex, vocabularyList: vocabularyList),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFD7DEE5),
            color: AppColors.iconColor,
          ),
          SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _vocabularyList.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: 350,
                    child: FlipCard(
                      front: FlashCardWithAudio(
                        text: _vocabularyList[index].korean,
                        language: 'Tiếng Hàn',
                        onSpeak: () => _speak(_vocabularyList[index].korean, 'ko-KR'),
                      ),
                      back: FlashCardWithAudio(
                        text: _vocabularyList[index].vietnamese,
                        language: 'Tiếng Việt',
                        onSpeak: () => _speak(_vocabularyList[index].vietnamese, 'vi-VN'),
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
