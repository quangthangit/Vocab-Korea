import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/models/UserModel.dart';
import '../app_colors.dart';
import '../services/UserService.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserService _userService = UserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    user = await _userService.getUserById(_auth.currentUser!.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: AppColors.iconColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Expanded(
                child: Text(
                  "Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.iconColor,
                  ),
                ),
              )
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFD9D9D9),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildListTile(
                      title: 'Username',
                      subtitle: user!.username, // Sử dụng username từ user
                      onTap: () {
                        _showChangeUsernameDialog(context, user!.id);
                      },
                    ),
                    const Divider(height: 1),
                    _buildListTile(
                      title: 'Email',
                      subtitle: user!.email, // Sử dụng email từ user
                      onTap: () {
                        // Handle tap event
                      },
                    ),
                    const Divider(height: 1),
                    _buildListTile(
                      title: 'Create password',
                      onTap: () {
                        // Handle tap event
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Hiển thị một widget loading hoặc thông báo khi user null
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), // Hoặc một thông báo nào đó
      );
    }
  }

  Widget _buildListTile({
    required String title,
    String? subtitle,
    required Function() onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    );
  }

  void _showChangeUsernameDialog(BuildContext context, String userId) {
    TextEditingController usernameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đổi Username'),
          backgroundColor: AppColors.background,
          content: TextField(
            controller: usernameController,
            decoration: InputDecoration(hintText: "Nhập username mới"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Xử lý khi nhấn "Cancel"
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                bool result = await _userService.updateUserName(userId, usernameController.text);
                if (result) {
                  setState(() {
                    user!.username = usernameController.text; // Cập nhật trực tiếp trong trạng thái
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đổi username thành công')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đổi username thất bại')),
                  );
                }
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }
}
