import 'package:flutter/material.dart';

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
          _buildItem(Icons.bookmarks_outlined, 'Học phần'),
          const SizedBox(height: 16),
          _buildItem(Icons.folder_copy_outlined, 'Thư mục'),
          const SizedBox(height: 16),
          _buildItem(Icons.supervisor_account, 'Tạo lớp học'),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
