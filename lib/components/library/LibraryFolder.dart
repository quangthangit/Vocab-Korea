import 'package:flutter/material.dart';
import 'package:vocabkpop/components/Folder.dart';
import 'package:vocabkpop/models/FolderModel.dart';

class LibraryFolder extends StatelessWidget {
  const LibraryFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Bộ lọc',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tuần này', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),
                ),
              ),
              Folder(folderModel: FolderModel(title: "Tiếng hàn sơ cấp", lessonList: [], createdAt: DateTime.now(),)),
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tháng 10 2024', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),
                ),
              ),
              Folder(folderModel: FolderModel(title: "Tiếng trung cấp", lessonList: [], createdAt: DateTime.now(),)),
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tháng 9 2024', style: TextStyle(fontSize: 20, fontFamily: 'Lobster')),
                ),
              ),
              Folder(folderModel: FolderModel(title: "Tiếng hàn sơ cấp", lessonList: [], createdAt: DateTime.now(),)),
            ],
          ),
        ],
      ),
    );
  }
}