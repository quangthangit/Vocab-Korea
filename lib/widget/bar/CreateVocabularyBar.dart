import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class CreateVocabularyBar extends StatelessWidget {
  const CreateVocabularyBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close,color: AppColors.iconColor,)
        ),
        const Text('Tạo học phần',style: TextStyle(fontWeight: FontWeight.bold),),
        const Row(
          children: [
            Icon(Icons.settings,color: AppColors.iconColor,),
            SizedBox(width: 10,),
            Icon(Icons.check,color: AppColors.iconColor,)
          ],
        )
      ],
    );
  }
}
