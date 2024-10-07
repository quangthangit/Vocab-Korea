import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vocabkpop/data_test/vocabulary_data.dart';
import 'package:vocabkpop/models/Vocabulary.dart';
import 'package:vocabkpop/widget/bar/FlashCardBar.dart';

class FlashCardPage extends StatefulWidget {
  @override
  _FlashCardPageState createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  late PageController _pageController;
  late List<Vocabulary> _vocabularyList;
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
                      front: _buildCard(
                        _vocabularyList[index].korean,
                        'Tiếng Hàn',
                      ),
                      back: _buildCard(
                        _vocabularyList[index].vietnamese,
                        'Tiếng Việt',
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

  Widget _buildCard(String text, String language) {
    return Container(
      width: 350,
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.volume_up, color: AppColors.iconColor, size: 30),
                  onPressed: () {
                    String textToSpeak = text;
                    String langToSpeak = language == 'Tiếng Hàn' ? 'ko-KR' : 'vi-VN';
                    _speak(textToSpeak, langToSpeak);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.star_border, color: AppColors.iconColor, size: 30),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
