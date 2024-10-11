import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class GameMatchBar extends StatelessWidget {
  final double seconds;

  const GameMatchBar({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.iconColor, size: 40),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Expanded(
          child: Text(
            '${seconds.toStringAsFixed(1)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.iconColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.iconColor, size: 40),
          onPressed: () {},
        ),
      ],
    );
  }
}
