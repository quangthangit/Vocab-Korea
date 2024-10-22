import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/FolderModel.dart';

class ListFolderBottomSheet extends StatelessWidget {
  const ListFolderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(width: 30,),
          _buildItem(context,'TIẾNG HÀN SƠ CẤP 1'),
          _buildItem(context,'TIẾNG HÀN SƠ CẤP 2'),
          _buildItem(context,'TIẾNG HÀN SƠ CẤP 3'),
        ],
    );
  }

  Widget _buildItem(BuildContext context,String title) {
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
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(Icons.folder_open,color: AppColors.iconColor,),
            const SizedBox(width: 10,),
            Text(
              title,
              style: const TextStyle(color: AppColors.iconColor,fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

}

