import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/FolderModel.dart';
import 'package:vocabkpop/services/FolderService.dart';

class ListFolderBottomSheet extends StatelessWidget {
  final FolderService _folderService = FolderService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _folderService.getFolderByUser(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading'));
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return const Center(child: Text("No folders found."));
        } else {
          var folders = snapshot.data as List;
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
              ...folders.map((folderModel) => _buildItem(context,folderModel)).toList(),
            ],
          );
        }
      },
    );
  }

  Widget _buildItem(BuildContext context, FolderModel folder) {
    return InkWell(
      onTap: () async {
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
            const Icon(Icons.folder_open, color: AppColors.iconColor),
            const SizedBox(width: 10),
            Text(
              folder.title,
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
}
