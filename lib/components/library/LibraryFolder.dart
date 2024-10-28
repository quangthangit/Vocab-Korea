import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/components/Folder.dart';
import 'package:vocabkpop/models/FolderModel.dart';
import 'package:vocabkpop/services/FolderService.dart';

class LibraryFolder extends StatelessWidget {
  final FolderService _folderService = FolderService();
  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    return ListView(
      children: [
        const SizedBox(height: 10),
        FutureBuilder<List<FolderModel>>(
          future: userId != null ? _folderService.getFolderByUser(userId) : Future.value([]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No lesson found.'));
            }
            final folderModel = snapshot.data!;

            return Column(
              children: [
                ...folderModel.map((folderModel) => Folder(folderModel: folderModel)).toList(),
              ],
            );
          },
        ),
      ],
    );
  }
}