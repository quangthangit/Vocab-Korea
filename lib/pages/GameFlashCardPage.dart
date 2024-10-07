import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlashCardWidget extends StatefulWidget {
  final List<Map<String, String>> vocabularyList;

  FlashCardWidget({required this.vocabularyList});

  @override
  _FlashCardWidgetState createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  late PageController _pageController;
  late FlutterTts flutterTts;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        // Cập nhật currentIndex dựa trên vị trí của PageController
        currentIndex = _pageController.page!.round(); // làm tròn trượt bên nào nhiều hơn
      });
    });

    flutterTts = FlutterTts();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Hàm phát âm với ngôn ngữ
  Future<void> _speak(String text, String language) async {
    await flutterTts.setLanguage(language); // Thiết lập ngôn ngữ
    await flutterTts.speak(text);
  }


  void _nextCard() {
    if (currentIndex < widget.vocabularyList.length - 1) {
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
    double progress = (currentIndex + 1) / widget.vocabularyList.length;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.iconColor, size: 40),
              onPressed: () {
                // Hành động khi nhấn nút đóng
              },
            ),
            Expanded(
              child: Text(
                '${currentIndex + 1} / ${widget.vocabularyList.length}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.iconColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.iconColor, size: 40),
              onPressed: () {
                // Hành động khi nhấn nút cài đặt
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Thanh tiến độ
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFD7DEE5),
            color: AppColors.iconColor,
          ),
          SizedBox(height: 20),

          // Hiển thị số câu đúng/sai
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       _buildScoreBox(10, Colors.orange[300]!),
          //       _buildScoreBox(8, Colors.green[300]!),
          //     ],
          //   ),
          // ),


          SizedBox(height: 20),

          // Thẻ từ vựng
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.vocabularyList.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index; // Cập nhật currentIndex khi trang thay đổi
                });
              },
              itemBuilder: (context, index) {
                return Center(
                  child: Container(
                    width: 350,
                    child: FlipCard(
                      front: _buildCard(
                        widget.vocabularyList[index]['korean']!,
                        'Tiếng Hàn',
                      ),
                      back: _buildCard(
                        widget.vocabularyList[index]['vietnamese']!,
                        'Tiếng Việt',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),


          // Nút điều hướng
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.grey),
                  onPressed: _previousCard,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 30, color: Colors.grey),
                  onPressed: _nextCard,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm dựng thẻ từ vựng
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
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.volume_up, color: AppColors.iconColor, size: 30),
              onPressed: () {
                // Xác định văn bản sẽ được phát âm dựa trên ngôn ngữ hiện tại
                String textToSpeak;
                String langToSpeak;

                // Nếu hiện tại là thẻ tiếng Hàn
                if (widget.vocabularyList[currentIndex]['korean'] != null) {
                  textToSpeak = widget.vocabularyList[currentIndex]['korean']!;
                  langToSpeak = 'ko-KR'; // Ngôn ngữ Hàn Quốc
                } else {
                  textToSpeak = widget.vocabularyList[currentIndex]['vietnamese']!;
                  langToSpeak = 'vi-VN'; // Ngôn ngữ Việt Nam
                }

                // Gọi hàm _speak với văn bản và ngôn ngữ đã xác định
                _speak(textToSpeak, langToSpeak);

              }, // Nút loa để phát âm thanh
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.star_border, color: AppColors.iconColor, size: 30),
              onPressed: () {}, // Nút đánh dấu sao
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

  // Hàm dựng ô điểm số
  // Widget _buildScoreBox(int score, Color color) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     decoration: BoxDecoration(
  //       color: color,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Text(
  //       score.toString(),
  //       style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
}
