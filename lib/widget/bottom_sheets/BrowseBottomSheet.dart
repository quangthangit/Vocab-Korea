import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/BasicUserInfo.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BrowseBottomSheet extends StatefulWidget {
  final String idClass;
  const BrowseBottomSheet({super.key, required this.idClass});

  @override
  _BrowseBottomSheetState createState() => _BrowseBottomSheetState();
}

class _BrowseBottomSheetState extends State<BrowseBottomSheet> {
  final ClassService _classService = ClassService();
  late Future<ClassModel?> classModelFuture;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    classModelFuture = _classService.getClassById(widget.idClass);
  }

  Future<void> loadData() async {
    setState(() {
      classModelFuture = _classService.getClassById(widget.idClass);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClassModel?>(
      future: classModelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.listUser.isEmpty) {
          return const Center(child: Text("No users found."));
        } else {
          var listUser = snapshot.data!.listUser;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const SizedBox(
                  width: 35,
                  child: Divider(
                    color: Color(0xFFD9D9D9),
                    thickness: 4,
                  ),
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: listUser.length,
                  itemBuilder: (context, index) {
                    return _buildUserItem(context, listUser[index]);
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildUserItem(BuildContext context, BasicUserInfo user) {
    return InkWell(
      onTap: () async {
        ClassModel? classModel = await classModelFuture;
        if (classModel != null) {
          List<String> listMember = List.from(classModel.idMember);
          listMember.add(user.idUser);
          List<BasicUserInfo> updatedListUser = List.from(classModel.listUser);

          updatedListUser.remove(user);

          ClassModel updatedClassModel = ClassModel(
            name: classModel.name,
            description: classModel.description,
            idFolder: classModel.idFolder,
            status: classModel.status,
            createdAt: classModel.createdAt,
            idUser: classModel.idUser,
            imageUser: classModel.imageUser,
            allowEdit: classModel.allowEdit,
            idMember: listMember,
            listUser: updatedListUser,
          );

          await _classService.updateClass(widget.idClass, updatedClassModel);
          _showToast('Duyệt thành công');
        } else {
          _showToast("Class not found.");
        }
      },
      splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.person, color: Colors.blue),
            const SizedBox(width: 10),
            Text(
              user.idUser,
              style: const TextStyle(
                color: AppColors.iconColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(String message) {
    fToast.showToast(
      child: createToast(message, Colors.green, Icons.check),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  Widget createToast(String message, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12.0),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
