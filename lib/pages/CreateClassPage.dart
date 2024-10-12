import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/widget/bar/CreateClassBar.dart';

class CreateClassPage extends StatefulWidget {
  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  bool _isPasswordEnabled = false;
  bool _isEditable = false;

  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ClassService _classService = ClassService();

  void _submitData() async {
    String className = _classNameController.text;
    String description = _descriptionController.text;
    String password = _isPasswordEnabled ? _passwordController.text : '';

    if (className.isEmpty || description.isEmpty || (_isPasswordEnabled && password.isEmpty)) {
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
              if (_isPasswordEnabled) Text('Mật khẩu: $password'),
              Text('Cho phép chỉnh sửa: ${_isEditable ? 'Có' : 'Không'}'),
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

                ClassModel classModel = ClassModel(
                  name: className,
                  description: description,
                  numberCollection: 0,
                  password: password,
                  createdAt: DateTime.now(),
                  idUser: FirebaseAuth.instance.currentUser!.uid,
                  allowEdit: allowEdit,
                  idMember: [
                    FirebaseAuth.instance.currentUser!.uid,
                  ]
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
                  _isPasswordEnabled = false;
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
        title: CreateClassBar(
          submit: _submitData,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                    value: _isPasswordEnabled,
                    onChanged: (bool? value) {
                      setState(() {
                        _isPasswordEnabled = value ?? false;
                      });
                    },
                  ),
                ),
                const Text("Cài mật khẩu"),
              ],
            ),
            if (_isPasswordEnabled)
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Nhập mật khẩu',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
          ],
        ),
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
