import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/pages/FlashCardPage.dart';
import 'package:vocabkpop/pages/MatchPage.dart';
import 'package:vocabkpop/pages/StudyPage.dart';
import 'package:vocabkpop/widget/bar/HomeLessonBar.dart';

class HomeLessonPage extends StatefulWidget {
  final LessonModel lessonModel;
  const HomeLessonPage({super.key, required this.lessonModel});

  @override
  _HomeLessonPageState createState() => _HomeLessonPageState();
}

class _HomeLessonPageState extends State<HomeLessonPage> {
  int selectedContainer = 0;
  late PageController _pageController;
  late List<VocabularyModel> _vocabularyList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _vocabularyList = widget.lessonModel.vocabulary;
  }

  void _onContainerTap(int index) {
    setState(() {
      selectedContainer = index;
    });
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FlashCardPage(vocabularyModel: _vocabularyList)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudyPage(vocabularyModel: _vocabularyList)),
        );
        break;
      case 2:
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MatchPage(vocabularyModel: _vocabularyList)),
        );
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
              height: 300,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: _vocabularyList.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: FlipCard(
                      front: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _vocabularyList[index].korean,
                              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      back: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _vocabularyList[index].vietnamese,
                              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                widget.lessonModel.title,
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
                  Text(
                    '${_vocabularyList.length} thuật ngữ',
                    style: const TextStyle(
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
                          color: selectedContainer == 0 ? const Color(0xFF812AEF) : const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Học hết 1',
                            style: TextStyle(
                              color: selectedContainer == 0 ? const Color(0xFFFFFFFF) : const Color(0xFF812AEF),
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
                          color: selectedContainer == 1 ? const Color(0xFF812AEF) : const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            'Học hết 2',
                            style: TextStyle(
                              color: selectedContainer == 1 ? const Color(0xFFFFFFFF) : const Color(0xFF812AEF),
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
            ..._vocabularyList.map((vocab) {
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
                        const Icon(Icons.volume_up_rounded),
                        const SizedBox(width: 20),
                        vocab.star == 1
                            ? const Icon(Icons.star, color: Colors.black)
                            : const Icon(Icons.star_border_rounded),
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
