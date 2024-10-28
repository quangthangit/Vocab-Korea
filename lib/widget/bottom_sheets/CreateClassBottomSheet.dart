import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/widget/bar/CreateBar.dart';

class CreateClassBottomSheet extends StatefulWidget {
  @override
  _CreateClassBottomSheetPageState createState() => _CreateClassBottomSheetPageState();
}

class _CreateClassBottomSheetPageState extends State<CreateClassBottomSheet> {
  bool _isPasswordEnabled = false;
  bool _isEditable = false;
  bool _status = false;

  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ClassService _classService = ClassService();

  void _submitData() async {
    String className = _classNameController.text;
    String description = _descriptionController.text;

    if (className.isEmpty || description.isEmpty ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng không để trống dữ liệu!'),
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
              Text('Tên lớp: $className'),
              Text('Mô tả: $description'),
              Text('Cho phép chỉnh sửa: ${_isEditable ? 'Có' : 'Không'}'),
              Text('Cho phép công khai: ${_status ? 'Có' : 'Không'}'),
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
                int allowEdit = _isEditable ? 1 : 0;
                int statusEdit = _status ? 1 : 0;
                ClassModel classModel = ClassModel(
                    name: className,
                    description: description,
                    status : statusEdit,
                    createdAt: DateTime.now(),
                    idUser: FirebaseAuth.instance.currentUser!.uid,
                    allowEdit: allowEdit,
                    imageUser: FirebaseAuth.instance.currentUser!.photoURL!,
                    idMember: [
                      FirebaseAuth.instance.currentUser!.uid,
                    ],
                    idFolder: []
                );

                bool isSuccess = await _classService.createClass(classModel);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isSuccess ? 'Thêm lớp thành công' : 'Thêm lớp thất bại'),
                  ),
                );

                FocusScope.of(context).unfocus();
                _classNameController.clear();
                _passwordController.clear();
                _descriptionController.clear();
                setState(() {
                  _isEditable = false;
                  _status = false;
                });
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
        title: CreateBar(
          submit: _submitData,
          title: 'Tạo lớp học mới',
        ),
      ),
      body: Column(
        children: [
          const LinearProgressIndicator(
            value: 0,
            backgroundColor: Color(0xFFD7DEE5),
            color: AppColors.iconColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _classNameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên lớp',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Mô tả',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: _isEditable,
                        onChanged: (bool? value) {
                          setState(() {
                            _isEditable = value ?? false;
                          });
                        },
                      ),
                    ),
                    const Text("Cho phép người khác điều chỉnh lớp học"),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        value: _status,
                        onChanged: (bool? value) {
                          setState(() {
                            _status = value ?? false;
                          });
                        },
                      ),
                    ),
                    const Text("Cho phép lớp học công khai"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _classNameController.dispose();
    _descriptionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}