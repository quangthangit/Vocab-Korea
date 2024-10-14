import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/models/FolderModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/services/FolderService.dart';
import 'package:vocabkpop/widget/bar/CreateClassBar.dart';

class CreateFolderPage extends StatefulWidget {
  final String idClass;

  CreateFolderPage({required this.idClass, Key? key}) : super(key: key);

  @override
  _CreateFolderPageState createState() => _CreateFolderPageState();
}

class _CreateFolderPageState extends State<CreateFolderPage> {
  final TextEditingController _folderNameController = TextEditingController();
  final FolderService _folderService = FolderService();
  final ClassService _classService = ClassService();

  void _submitFolder() {
    String folderName = _folderNameController.text;
    if (folderName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập tên thư mục!'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: const Text('Xác nhận thông tin'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tên thư mục: ${_folderNameController.text}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () async {
                FolderModel folderModel = FolderModel(
                  title: folderName,
                  createdAt: DateTime.now(),
                  lessonList: [],
                );
                Map<String,dynamic> result = await _folderService.createFolder(folderModel);

                if(result['success'] && result['id']!=null) {

                  ClassModel? classCurrent = await _classService.getClassById(widget.idClass);

                  classCurrent?.idFolder.add(result['id']);

                  _classService.updateClass(widget.idClass, classCurrent!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Thêm thư mục thành công'),
                    ),
                  );
                }
                FocusScope.of(context).unfocus();
                _folderNameController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: CreateClassBar(
          submit: _submitFolder,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _folderNameController,
              decoration: const InputDecoration(
                labelText: 'Tên thư mục',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _folderNameController.dispose();
    super.dispose();
  }
}