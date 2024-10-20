import 'package:flutter/material.dart';

import '../../app_colors.dart';

class HomeLessonBar extends StatelessWidget {
  const HomeLessonBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.iconColor, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.share, color: AppColors.iconColor, size: 20),
              onPressed: () {
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.iconColor, size: 20),
              onPressed: () {
              },
            ),
          ],
        )
      ],
    );
  }
}
