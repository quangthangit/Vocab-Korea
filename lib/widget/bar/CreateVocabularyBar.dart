import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class CreateVocabularyBar extends StatelessWidget {
  final VoidCallback onSave;
  const CreateVocabularyBar({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: AppColors.iconColor),
        ),
        const Text(
          'Tạo học phần',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onSave,
              icon: const Icon(Icons.check, color: AppColors.iconColor),
            ),
          ],
        ),
      ],
    );
  }
}

