import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class ResultMatchbar extends StatelessWidget {
  final VoidCallback submit;
  final String title;
  ResultMatchbar({super.key, required this.submit,required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.iconColor, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(width: 20,),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.iconColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
