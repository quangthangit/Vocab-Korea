import 'package:flutter/material.dart';

import '../../app_colors.dart';

class HomeLessonBar extends StatelessWidget {
  final VoidCallback btnShare;
  final VoidCallback moreVert;
  const HomeLessonBar({super.key, required this.btnShare, required this.moreVert});

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
                btnShare();
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.iconColor, size: 20),
              onPressed: () {
                moreVert();
              },
            ),
          ],
        ),
      ],
    );
  }
}
