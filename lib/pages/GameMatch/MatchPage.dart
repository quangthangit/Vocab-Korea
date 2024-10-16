import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/pages/GameMatch/GameMatchPage.dart';
import 'package:vocabkpop/widget/bar/MatchBar.dart';

class MatchPage extends StatelessWidget {
  final LessonModel lessonModel;

  const MatchPage({
    super.key,
    required this.lessonModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: MatchBar(),
      ),
      body: Column(
        children: [
          const LinearProgressIndicator(
            value: 1.0,
            backgroundColor: AppColors.background,
            color: AppColors.iconColor,
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bạn đã sẵn sàng ?",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ghép tất cả các thuật ngữ theo \n định nghĩa của chúng",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameMatchPage(
                            lessonModel: lessonModel,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(370, 60),
                      backgroundColor: AppColors.backgroundColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "Bắt đầu chơi",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
