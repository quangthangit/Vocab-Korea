import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/pages/CreateFolderPage.dart';

class DetailClassBar extends StatelessWidget {
  final String idClass;
  final String title;

  DetailClassBar({super.key, required this.idClass, required this.title});

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
          icon: const Icon(Icons.more_outlined, color: AppColors.iconColor, size: 30),
          onSelected: (value) {

            if (value == 'add_folder') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateFolderPage(idClass: idClass)),
              );
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