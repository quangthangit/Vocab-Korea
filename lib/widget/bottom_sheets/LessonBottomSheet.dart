import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/widget/bottom_sheets/ListFolderBottomSheet.dart';

class LessonBottomSheet extends StatelessWidget {
  final String idLesson;
  const LessonBottomSheet({super.key, required this.idLesson});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 35,
            child: Divider(
              color: Color(0xFFD9D9D9),
              thickness: 4,
            ),
          ),
          const SizedBox(height: 16),
          _buildItem(context, Icons.add_chart, 'Thêm vào thư mục'),
          const SizedBox(height: 16),
          _buildItem(context, Icons.bookmarks_outlined, 'Chia sẻ bài học'),
          const SizedBox(height: 16),
          _buildItem(context, Icons.folder_copy_outlined, 'Lưu và chỉnh sửa'),
          const SizedBox(height: 16),
          _buildItem(context, Icons.info_outline, 'Thông tin bài học'),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String title) {
    return InkWell(
      onTap: () async {
        if (ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).pop();
        }
        if (title == "Thêm vào thư mục") {
          await _showListFolder(context);
        }
      },
      splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon,color: AppColors.iconColor,),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(color: AppColors.iconColor,fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showListFolder(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return ListFolderBottomSheet(idLesson: idLesson,);
      },
    );
  }
}
