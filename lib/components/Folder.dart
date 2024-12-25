import 'package:flutter/material.dart';
import 'package:vocabkpop/models/FolderModel.dart';
import 'package:vocabkpop/pages/DetailFolderPage.dart';

import '../app_colors.dart';

class Folder extends StatelessWidget {
  final FolderModel folderModel;
  const Folder({super.key, required this.folderModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailFolderPage(idFolder: folderModel.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Align(
            //   alignment: Alignment.centerLeft,
            //   child: Icon(Icons.folder_copy_outlined,size: 25),
            // ),
            // const SizedBox(height: 20,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("${folderModel.title}",style: TextStyle(fontSize: 15,fontFamily: 'Lobster')),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEEEEEE),
              ),
              child: Text(
                '${folderModel.lessonList.length} Học phần',
                style: const TextStyle(fontSize: 15, fontFamily: 'Lobster'),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage("https://d1hjkbq40fs2x4.cloudfront.net/2017-08-21/files/landscape-photography_1645-t.jpg"),
                ),
                const SizedBox(width: 5),
                Text(
                  folderModel.idUser,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}