import 'package:flutter/material.dart';
import 'package:vocabkpop/data_test/vocabulary_data.dart';
import 'package:vocabkpop/widget/HomeLessonBar.dart';

class HomeLesson extends StatefulWidget {
  const HomeLesson({super.key});

  @override
  _HomeLessonState createState() => _HomeLessonState();
}

class _HomeLessonState extends State<HomeLesson> {
  int selectedContainer = 0;

  void _onContainerTap(int index) {
    setState(() {
      selectedContainer = index;
    });
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/flashcard');
        break;
      case 1:
        Navigator.pushNamed(context, '/study');
        break;
      case 2:
        break;
      case 3:
        Navigator.pushNamed(context, '/match');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          children: [
            const HomeLessonBar(),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  '사람',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'Trung cấp 3',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      SizedBox(width: 5),
                      Text(
                        'user09217662',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'KayPhoDu',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 1,
                    height: 10,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    '92 thuật ngữ',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'KayPhoDu',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ...List.generate(4, (index) {
              List<String> titles = ['Thẻ ghi nhớ', 'Học', 'Kiểm tra', 'Ghép thẻ'];
              return GestureDetector(
                onTap: () => _navigateToPage(index),
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  padding: const EdgeInsetsDirectional.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        index == 0
                            ? Icons.bookmarks
                            : index == 1
                            ? Icons.computer
                            : index == 2
                            ? Icons.menu_book
                            : Icons.save_rounded,
                        color: const Color(0xFF812AEF),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        titles[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
              padding: const EdgeInsetsDirectional.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onContainerTap(0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedContainer == 0 ? Color(0xFF812AEF) : const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Học hết 1',
                            style: TextStyle(
                              color: selectedContainer == 0 ? Color(0xFFFFFFFF) : const Color(0xFF812AEF),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onContainerTap(1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedContainer == 1 ? Color(0xFF812AEF) : const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Học hết 2',
                            style: TextStyle(
                              color: selectedContainer == 1 ? Color(0xFFFFFFFF) : const Color(0xFF812AEF),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Vocabulary List
            ...vocabularyList.map((vocab) {
              bool shouldShowVocab = selectedContainer == 0 || (selectedContainer == 1 && vocab.star == 1);

              return shouldShowVocab
                  ? Container(
                margin: const EdgeInsets.only(right: 30, top: 20, left: 30, bottom: 10),
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          vocab.korean,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          vocab.vietnamese,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.volume_up_rounded),
                        SizedBox(width: 20),
                        (vocab.star == 1) ? Icon(Icons.star, color: Colors.black) : Icon(Icons.star_border_rounded),
                      ],
                    ),
                  ],
                ),
              )
                  : Container();
            }).toList(),
          ],
        ),
      ),
    );
  }
}
