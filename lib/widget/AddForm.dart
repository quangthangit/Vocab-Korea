import 'package:flutter/material.dart';
import 'package:vocabkpop/pages/CreateVocabularyPage.dart';
import 'package:vocabkpop/widget/form/ClassRoomForm.dart';
import 'package:vocabkpop/widget/form/FolderForm.dart';

class AddForm extends StatelessWidget {
  const AddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
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
          _buildItem(context, Icons.bookmarks_outlined, 'Học phần'),
          const SizedBox(height: 16),
          _buildItem(context, Icons.folder_copy_outlined, 'Thư mục'),
          const SizedBox(height: 16),
          _buildItem(context, Icons.supervisor_account, 'Tạo lớp học'),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () async {
        if (ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).pop();
        }
        if (title == "Học phần") {
          await _showBottomSheet3(context);
        } else if (title == "Tạo lớp học") {
          await _showBottomSheet2(context);
        } else if (title == "Thư mục") {
          await _showBottomSheet(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AddFolderForm();
      },
    );
  }

  Future<void> _showBottomSheet2(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AddClassRoomForm();
      },
    );
  }

  Future<void> _showBottomSheet3(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return CreateVocabularyPage();
      },
    );
  }
}
