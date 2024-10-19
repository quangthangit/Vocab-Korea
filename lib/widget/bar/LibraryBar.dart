import 'package:flutter/material.dart';
import 'package:vocabkpop/components/library/LibraryClassRoom.dart';
import 'package:vocabkpop/components/library/LibraryFolder.dart';
import 'package:vocabkpop/components/library/LibraryLesson.dart';

class LibraryBar extends StatefulWidget {
  const LibraryBar({super.key});

  @override
  _LibraryBarState createState() => _LibraryBarState();
}

class _LibraryBarState extends State<LibraryBar> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Học phần"),
              Tab(text: "Thư mục"),
              Tab(text: "Lớp học"),
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
                LibraryLesson(),
                LibraryFolder(),
                LibraryClassRoom()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
