import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class CreateBar extends StatelessWidget {
  final VoidCallback submit;
  final String title;
  CreateBar({super.key, required this.submit,required this.title});

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
        Row(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.iconColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        IconButton(
          icon: const Icon(Icons.check, color: AppColors.iconColor, size: 30),
          onPressed: () {
            submit();
          },
        ),
      ],
    );
  }
}
