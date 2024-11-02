import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/components/ClassRoom.dart';
import 'package:vocabkpop/components/Lesson.dart';
import 'package:vocabkpop/models/ClassModel.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/services/ClassService.dart';
import 'package:vocabkpop/services/LessonService.dart';

class ResultSearchPage extends StatefulWidget {
  final String text;

  const ResultSearchPage({Key? key, required this.text}) : super(key: key);

  @override
  _ResultSearchWidgetState createState() => _ResultSearchWidgetState();
}


class _ResultSearchWidgetState extends State<ResultSearchPage> {
  final ClassService _classService = ClassService();
  final LessonService _lessonService = LessonService();
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _searchText = widget.text;
  }

  void _handleTextChanged(String text) {
    setState(() {
      _searchText = text;
    });
  }

  void _handleSubmit(String text) {
    setState(() {
      _searchText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.iconColor, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  initialValue: _searchText,
                  onChanged: _handleTextChanged,
                  onFieldSubmitted: _handleSubmit,
                  decoration: InputDecoration(
                    hintText: 'Học phần, lớp học',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.brown.withOpacity(0.5),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.iconColor,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16.0,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(child: buildTabView())
        ],
      ),
    );
  }

  Widget buildTabView() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Tất cả"),
              Tab(text: "Lớp học"),
              Tab(text: "Bài học"),
            ],
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: TabBarView(
              children: [
                allTab(_searchText),
                classTab(_searchText),
                lessonTab(_searchText),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget classTab(String searchTerm) {
    return FutureBuilder<List<ClassModel>>(
      future: _classService.searchClass(searchTerm),
      builder: (BuildContext context, AsyncSnapshot<List<ClassModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Lỗi khi tải lớp học: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có lớp học nào'));
        }

        List<ClassModel> classList = snapshot.data!;

        return ListView.builder(
          itemCount: classList.length,
          itemBuilder: (context, index) {
            ClassModel classModel = classList[index];
            return ClassRoom(classModel: classModel);
          },
        );
      },
    );
  }

  Widget lessonTab(String searchTerm) {
    return FutureBuilder<List<LessonModel>>(
      future: _lessonService.searchLesson(searchTerm),
      builder: (BuildContext context, AsyncSnapshot<List<LessonModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Lỗi khi tải bài học: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có bài học nào'));
        }

        List<LessonModel> lessonList = snapshot.data!;

        return ListView.builder(
          itemCount: lessonList.length,
          itemBuilder: (context, index) {
            LessonModel lessonModel = lessonList[index];
            return Lesson(lessonModel: lessonModel);
          },
        );
      },
    );
  }

  Widget allTab(String searchTerm) {
    return FutureBuilder(
      future: Future.wait([
        _classService.searchClass(searchTerm),
        _lessonService.searchLesson(searchTerm),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Lỗi khi tải dữ liệu: ${snapshot.error}'));
        }

        if (!snapshot.hasData || (snapshot.data![0] as List).isEmpty && (snapshot.data![1] as List).isEmpty) {
          return const Center(child: Text('Không có dữ liệu nào'));
        }

        List<ClassModel> classList = snapshot.data![0];
        List<LessonModel> lessonList = snapshot.data![1];

        List<Widget> combinedList = [];

        if (classList.isNotEmpty) {
          combinedList.add(const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Lớp học", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ));
          combinedList.addAll(classList.map((classModel) => ClassRoom(classModel: classModel)).toList());
        }

        if (lessonList.isNotEmpty) {
          combinedList.add(const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text("Bài học", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ));
          combinedList.addAll(lessonList.map((lessonModel) => Lesson(lessonModel: lessonModel)).toList());
        }

        return ListView.builder(
          itemCount: combinedList.length,
          itemBuilder: (context, index) {
            return combinedList[index];
          },
        );
      },
    );
  }

}
