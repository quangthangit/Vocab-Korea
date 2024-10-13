import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class DetailClassBar extends StatelessWidget {

  final Function submit;
  DetailClassBar({super.key,required this.submit});

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
              "Lớp",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.iconColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        IconButton(
          icon: const Icon(Icons.more_outlined, color: AppColors.iconColor, size: 30),
          onPressed: () {
            submit();
          },
        ),
      ],
    );
  }
}