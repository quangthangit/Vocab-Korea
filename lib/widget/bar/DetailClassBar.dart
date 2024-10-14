import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class DetailClassBar extends StatelessWidget {
  final VoidCallback btn_addFolder;

  DetailClassBar({super.key, required this.btn_addFolder});

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
              'Lớp',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.iconColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        PopupMenuButton<String>(
          color: AppColors.background,
          icon: const Icon(Icons.more_outlined, color: AppColors.iconColor, size: 30),
          onSelected: (value) {

            if (value == 'add_folder') {
              btn_addFolder();
            } else if (value == 'add_member') {

            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                value: 'add_folder',
                child: Text('Thêm thư mục'),

              ),
              const PopupMenuItem(
                value: 'add_member',
                child: Text('Thêm thành viên'),
              ),
            ];
          },
        ),
      ],
    );
  }
}