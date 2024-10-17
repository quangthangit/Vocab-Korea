import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';

class StudyEssayBar extends StatelessWidget {
  final int currentIndex;
  final List<VocabularyModel> vocabularyList;
  const StudyEssayBar({super.key, required this.currentIndex, required this.vocabularyList});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.iconColor, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Text(
            '${currentIndex + 1} / ${vocabularyList.length}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.iconColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.iconColor, size: 30),
          onPressed: () {

          },
        ),
      ],
    );
  }
}
