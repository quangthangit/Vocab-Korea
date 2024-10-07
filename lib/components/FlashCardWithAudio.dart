import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class FlashCardWithAudio extends StatelessWidget {
  final String text;
  final String language;
  final VoidCallback onSpeak;

  const FlashCardWithAudio({
    Key? key,
    required this.text,
    required this.language,
    required this.onSpeak,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.volume_up, color: AppColors.iconColor, size: 30),
                  onPressed: onSpeak,
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