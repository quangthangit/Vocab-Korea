import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/models/BasicUserInfo.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/pages/DetailClassPage.dart';

import '../app_colors.dart';
import '../services/ClassService.dart';

class ClassRoom extends StatelessWidget {
  final ClassModel classModel;
  final User? _user = FirebaseAuth.instance.currentUser;
  ClassRoom({super.key, required this.classModel});

  Future<void> _navigateToDetailPage(BuildContext context) async {
    final String userId = _user!.uid;
    final String userPhotoURL = _user!.photoURL ?? '';

    ClassService classService = ClassService();
    bool userExistsInClass = await classService.checkExistUser(classModel.id, userId);

    if (userExistsInClass) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailClassPage(idClass: classModel.id)),
      );
    } else {
      if (classModel.status == 0) { // private class

        if(checkApprove(userId)) {
          showNotificationDialog(context, "Bạn đã yêu cầu tham gia lớp học và cần chờ phê duyệt.");
        } else {
          showConfirmationDialog(context, () async {

            BasicUserInfo approveUser = BasicUserInfo(idUser: userId, urlAvt: userPhotoURL);
            ClassModel newClass = classModel;
            newClass.listUser.add(approveUser);

            bool result = await classService.updateClass(classModel.id, newClass);
            if(result) {
              showNotificationDialog(context, "Đã yêu cầu vào lớp học thành công.");
            }
          });
        }

      } else if (classModel.status == 1) {

        showConfirmationDialog(context, () async {

          ClassModel newClass = classModel;
          newClass.idMember.add(userId);

          bool result = await classService.updateClass(classModel.id, newClass);
          if(result) {
            showNotificationDialog(context, "Đã tham gia lớp học thành công.");
          }
        });
      }
    }
  }

  bool checkApprove(String idUser) {
    return classModel.listUser.any((approveUser) => approveUser.idUser == idUser);
  }

  void showNotificationDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context)
    {
      return AlertDialog(
        title: const Text("Thông báo"),
        content: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    });
  }

  void showConfirmationDialog(BuildContext context, VoidCallback onConfirmed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận tham gia lớp học"),
          content: const Text("Bạn có chắc chắn muốn tham gia lớp học này không?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Hủy"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirmed();
              },
              child: Text("Xác nhận"),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToDetailPage(context);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(classModel.name,style: const TextStyle(fontSize: 15,fontFamily: 'Lobster')),
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(classModel.description,style: const TextStyle(fontSize: 12,)),
            // ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Row(
                  children: [
                    const Icon(Icons.collections_bookmark_outlined,color: AppColors.iconColor,),
                    const SizedBox(width: 10,),
                    Text('${classModel.idFolder.length} Thư mục',style: const TextStyle(fontSize: 15,fontFamily: 'Lobster'))
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.supervisor_account,color: AppColors.iconColor),
                    const SizedBox(width: 10,),
                    Text('${classModel.idMember.length}',style: const TextStyle(fontSize: 15,fontFamily: 'Lobster'))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
