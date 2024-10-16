import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class DetailClassBar extends StatelessWidget {
  final VoidCallback btn_addFolder;
  final String title;
  final List<String> item;

  DetailClassBar({super.key, required this.btn_addFolder, required this.title, required this.item});

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
        PopupMenuButton<String>(
          color: AppColors.background,
          icon: const Icon(Icons.more_vert, color: AppColors.iconColor, size: 30),
          onSelected: (value) {

            if (value == 'Thêm bài học') {
              btn_addFolder();
            } else if (value == 'Thêm thư mục') {
              btn_addFolder();
            }
          },
          itemBuilder: (BuildContext context) {
            return item.map((i) {
              return PopupMenuItem<String>(
                value: i,
                child: Text(i),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}