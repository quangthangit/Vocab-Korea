import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/components/Folder.dart';
import 'package:vocabkpop/models/FolderModel.dart';
import 'package:vocabkpop/services/FolderService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListFolderBottomSheet extends StatefulWidget {
  final String idLesson;
  const ListFolderBottomSheet({super.key, required this.idLesson});

  @override
  _ListFolderBottomSheetState createState() => _ListFolderBottomSheetState();
}

class _ListFolderBottomSheetState extends State<ListFolderBottomSheet> {
  late String idLesson;
  final FolderService _folderService = FolderService();
  late FToast fToast;
  late Future<Object>listForlder;
  @override
  void initState() {
    super.initState();
    _refreshData();
    fToast = FToast();
    fToast.init(context);
    idLesson = widget.idLesson;
  }

  Future<void> _refreshData() async {
    listForlder = _folderService.getFolderByUser(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> _addLesson(FolderModel folder) async {
    List<String> listLesson = List.from(folder.lessonList);
    listLesson.add(idLesson);
    folder.lessonList = listLesson;
    await _folderService.updateFolder(folder.id, folder);
    setState(() {
      _refreshData();
    });
    fToast.showToast(
      child: createToast('Thêm thành công',Colors.green,Icons.check),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 1,),
    );
  }

  Future<void> _deleteLesson(FolderModel folder) async {
    List<String> listLesson = List.from(folder.lessonList);
    listLesson.remove(idLesson);
    folder.lessonList = listLesson;
    await _folderService.updateFolder(folder.id, folder);
    setState(() {
      _refreshData();
    });
    fToast.showToast(
      child: createToast('Xóa thành công',Colors.red,Icons.close),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 1,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listForlder,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return const Center(child: Text("No folders found."));
        } else {
          var folders = snapshot.data as List<FolderModel>;
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
                  shrinkWrap: true,
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    return _buildItem(context, folders[index]);
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget createToast(String message,Color color,IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,color: Colors.white,),
          const SizedBox(
            width: 12.0,
          ),
          Text(message,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, FolderModel folder) {
    return InkWell(
      onTap: () async {
        folder.lessonList.contains(idLesson) ? _deleteLesson(folder) : _addLesson(folder);
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
            folder.lessonList.contains(idLesson) ? const Icon(Icons.check, color: Colors.green) : const Icon(Icons.folder_open, color: AppColors.iconColor),
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
