import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class StudyBar extends StatelessWidget {
  const StudyBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.iconColor, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
