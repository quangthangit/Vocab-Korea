import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class MatchBar extends StatelessWidget {
  const MatchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.iconColor, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        const Expanded(
          child: Text(
            'Ghép thẻ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.iconColor,
              fontSize: 30,
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
