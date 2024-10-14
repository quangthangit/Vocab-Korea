import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/models/FolderModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/services/FolderService.dart';
import 'package:vocabkpop/widget/bar/CreateBar.dart';

class CreateFolderBottomSheet extends StatefulWidget {
  final String idClass;

  CreateFolderBottomSheet({required this.idClass, Key? key}) : super(key: key);

  @override
  _CreateFolderBottomSheetState createState() => _CreateFolderBottomSheetState();
}

class _CreateFolderBottomSheetState extends State<CreateFolderBottomSheet> {
  final TextEditingController _folderNameController = TextEditingController();
  final FolderService _folderService = FolderService();
  final ClassService _classService = ClassService();

  void _submitFolder() async {
    String folderName = _folderNameController.text;
    if (folderName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập tên thư mục!'),
        ),
      );
      return;
    }

    FolderModel folderModel = FolderModel(
      title: folderName,
      createdAt: DateTime.now(),
      lessonList: [],
    );

    Map<String, dynamic> result = await _folderService.createFolder(folderModel);
    if (result['success'] && result['id'] != null) {
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: CreateBar(
          submit: _submitFolder,
          title: 'Tạo thư mục mới',
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