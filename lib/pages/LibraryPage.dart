import 'package:flutter/material.dart';
import 'package:vocabkpop/widget/library/ClassRoomList.dart';
import 'package:vocabkpop/widget/library/FolderList.dart';
import 'package:vocabkpop/widget/LibraryBar.dart';
import 'package:vocabkpop/widget/library/VocabularyLessonList.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (_selectedIndex) {
      case 0:
        content = const VocabularyLessonList();
        break;
      case 1:
        content = const FolderList();
        break;
      case 2:
        content = const ClassRoomList();
        break;
      default:
        content = const VocabularyLessonList();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            LibraryBar(onItemTapped: _onItemTapped),
            Expanded(
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
