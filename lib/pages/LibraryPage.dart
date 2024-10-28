import 'package:flutter/material.dart';
import 'package:vocabkpop/components/library/LibraryClassRoom.dart';
import 'package:vocabkpop/components/library/LibraryFolder.dart';
import 'package:vocabkpop/components/library/LibraryLesson.dart';
import 'package:vocabkpop/widget/bar/LibraryBar.dart';
import 'package:vocabkpop/app_colors.dart';

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
      case 1:
        content = LibraryFolder();
        break;
      case 2:
        content = LibraryClassRoom();
        break;
      default:
        content = LibraryLesson();
    }

    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thư viện',
                    style: TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                  ),
                ],
              ),
            ),
            Flexible(child: LibraryBar()),
          ],
        ),
      ),
    );
  }
}
