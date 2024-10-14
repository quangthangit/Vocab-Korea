import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/components/User.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/models/UserModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/services/FolderService.dart';
import 'package:vocabkpop/services/UserService.dart';
import 'package:vocabkpop/widget/bar/DetailClassBar.dart';

import '../components/Folder.dart';
import '../models/FolderModel.dart';

class DetailClassPage extends StatelessWidget {
  final String idClass;
  final ClassService _classService = ClassService();
  final FolderService _folderService = FolderService();
  final UserService _userService = UserService();

  DetailClassPage({super.key, required this.idClass});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClassModel?>(
      future: _classService.getClassById(idClass),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Lỗi khi tải dữ liệu lớp học: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Không tìm thấy thông tin lớp học.')),
          );
        }

        // Dữ liệu lớp học đã sẵn sàng
        ClassModel classData = snapshot.data!;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.background,
            title: DetailClassBar(idClass: idClass, title: "Lớp"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                infoClass(classData),
                const SizedBox(height: 20),
                Expanded(child: buildTabView(classData)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget infoClass(ClassModel classData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              classData.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Text(
              '${classData.idMember.length} thành viên',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 5),
            Text(convertTime(classData.createdAt)),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          classData.description,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget buildTabView(ClassModel classModel) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Thư mục"),
              Tab(text: "Thành viên"),
            ],
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 18),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
          ),
          Expanded(
            child: TabBarView(
              children: [
                folderTab(classModel.idFolder),
                memberTab(classModel.idMember),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String convertTime(DateTime time) {
    return "${time.day}-${time.month}-${time.year}";
  }

  // Hàm xây dựng tab Thư mục
  Widget folderTab(List<String> listIdFolder) {
    if (listIdFolder.isEmpty) {
      return const Center(child: Text("Không có thư mục nào"));
    } else {
      return FutureBuilder<List<FolderModel?>>(
        future: Future.wait(
          listIdFolder.map((folderId) => _folderService.getFolderById(folderId)),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Lỗi khi tải thư mục'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có thư mục nào'));
          }

          List<FolderModel?> folderList = snapshot.data!;

          return ListView.builder(
            itemCount: folderList.length,
            itemBuilder: (context, index) {
              FolderModel? folder = folderList[index];
              if (folder == null) {
                return const ListTile(
                  title: Text('Không thể tải thư mục.'),
                );
              }

              return Folder(folderModel: folder);
            },
          );
        },
      );
    }
  }


  Widget memberTab(List<String> listIdMember) {
    if (listIdMember.isEmpty) {
      return const Center(child: Text("Không có thành viên nào"));
    } else {
      return FutureBuilder<List<UserModel?>>(
        future: Future.wait(
          listIdMember.map((userID) => _userService.getUserById(userID)),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Lỗi khi tải thành viên'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có thành viên nào'));
          }

          List<UserModel?> userList = snapshot.data!;

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              UserModel? user = userList[index];
              if (user == null) {
                return const ListTile(
                  title: Text('Không thể tải danh sách thành viên.'),
                );
              }
              return  User(userModel: user);
            },
          );
        },
      );
    }
  }
}