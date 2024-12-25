import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/components/Lesson.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/services/LessonService.dart';
import 'package:vocabkpop/services/FolderService.dart';
import 'package:vocabkpop/widget/bar/DetailClassBar.dart';
import 'package:vocabkpop/widget/bottom_sheets/CreateVocabularyBottomSheet.dart';
import '../models/FolderModel.dart';

class DetailFolderPage extends StatefulWidget {
  final String idFolder;

  const DetailFolderPage({super.key, required this.idFolder});

  @override
  _DetailFolderPageState createState() => _DetailFolderPageState();
}

class _DetailFolderPageState extends State<DetailFolderPage> {
  final FolderService _folderService = FolderService();
  final LessonService _lessonService  = LessonService();
  late Future<FolderModel?> _folderDataFuture;

  @override
  void initState() {
    super.initState();
    _folderDataFuture = _folderService.getFolderById(widget.idFolder);
  }

  Future<void> _refreshData() async {
    setState(() {
      _folderDataFuture = _folderService.getFolderById(widget.idFolder);
    });
  }

  Future<void> showFormCreateFolder(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return CreateVocabularyBottomSheet(idFolder: widget.idFolder,);
      },
    ).then((_) {
      _refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FolderModel?>(
      future: _folderDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Lỗi khi tải dữ liệu thư mục: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Không tìm thấy thông tin thư mục.')),
          );
        }

        FolderModel folderData = snapshot.data!;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.background,
            title: DetailClassBar(btn_addFolder: () => showFormCreateFolder(context), title: "Thư mục", item: ["Thêm bài học"], btn_browse: () {  },),
          ),
          body: Column(
            children: [
              const Divider(
                color: AppColors.iconColor,
                height: 1,
                thickness: 15,
              ),
              infoFolder(folderData),
              Expanded(child: buildTabView(folderData)),
            ],
          ),
        );
      },
    );
  }

  Widget infoFolder(FolderModel folderData) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                folderData.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Text(
                '${folderData.lessonList.length} bài học',
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.access_time),
              const SizedBox(width: 5),
              Text('Ngày tạo ${convertTime(folderData.createdAt)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTabView(FolderModel folder) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Thư mục",),
            ],
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              children: [
                lessonTab(folder.lessonList),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String convertTime(DateTime time) {
    return "${time.day}-${time.month}-${time.year}";
  }

  Widget lessonTab(List<String> listIdLesson) {
    if (listIdLesson.isEmpty) {
      return const Center(child: Text("Không có bài học nào"));
    } else {
      return FutureBuilder<List<LessonModel?>>(
        future: Future.wait(
          listIdLesson.map((lessonId) => _lessonService.getLessonById(lessonId)).toList(), // Đóng ngoặc đúng cách và thêm `toList()`
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Lỗi khi tải bài học'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có bài học nào'));
          }

          List<LessonModel?> lessonList = snapshot.data!;

          return ListView.builder(
            itemCount: lessonList.length,
            itemBuilder: (context, index) {
              LessonModel? lesson = lessonList[index];
              if (lesson == null) {
                return const ListTile(
                  title: Text('Không thể tải bài học.'),
                );
              }
              return Lesson(lessonModel: lesson);
            },
          );
        },
      );
    }
  }
}
