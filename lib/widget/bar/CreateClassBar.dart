import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class CreateClassBar extends StatelessWidget {
  final VoidCallback submit;

  CreateClassBar({super.key, required this.submit});

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
        const Row(
          children: [
            Text(
              "Tạo lớp học mới",
              textAlign: TextAlign.center,
              style: TextStyle(
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
