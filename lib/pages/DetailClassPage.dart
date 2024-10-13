import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/widget/bar/DetailClassBar.dart';

class DetailClassPage extends StatelessWidget {
  final String idClass;
  final ClassService _classService = ClassService();

  DetailClassPage({super.key, required this.idClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: DetailClassBar(submit: () {}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            infoClass(idClass),
            const SizedBox(height: 20),
            Expanded(child: buildTabView()),
          ],
        ),
      ),
    );
  }

  Widget infoClass(String idClass) {
    return FutureBuilder<ClassModel?>(
      future: _classService.getClassById(idClass),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Lỗi khi tải dữ liệu lớp học.'));
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Không tìm thấy thông tin lớp học.'));
        }
        ClassModel classData = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Thang',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(
                  '10 thành viên',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              classData.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  Widget buildTabView() {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: "Học phần"),
              Tab(text: "Thành viên"),
            ],
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 18),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
          ),
          Flexible(
            child: TabBarView(
              children: [
                Center(child: Text("Danh sách học phần")),
                Center(child: Text("Danh sách thành viên")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
