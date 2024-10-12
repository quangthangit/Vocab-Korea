import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/services/TranslationService.dart';
import 'package:vocabkpop/widget/bar/CreateVocabularyBar.dart';

class CreateVocabularyPage extends StatefulWidget {
  const CreateVocabularyPage({super.key});

  @override
  _CreateVocabularyPageState createState() => _CreateVocabularyPageState();
}

class _CreateVocabularyPageState extends State<CreateVocabularyPage> {
  bool _showTextField = false;
  String lessonTitle = '';
  String lessonDescription = '';
  List<VocabularyModel> vocabularyList = [];

  List<Map<String, dynamic>> numberForms = [
    {'term': '', 'definition': '', 'termController': TextEditingController(), 'definitionController': TextEditingController()}
  ];
  TranslationService _translationService = TranslationService();

  void updateLessonInfo(String title, String description) {
    setState(() {
      lessonTitle = title;
      lessonDescription = description;
    });
  }

  Future<void> changeTrans(int index, String value) async {
    String translatedText = await _translationService.translateText(value);
    dev.log(translatedText);
    setState(() {
      numberForms[index]['definition'] = translatedText;
      numberForms[index]['definitionController'].text = translatedText;
    });
  }

  void createVocabularyModel() {
    for (var form in numberForms) {
      vocabularyList.add(
        VocabularyModel(
          0,
          korean: form['termController'].text,
          vietnamese: form['definitionController'].text,
        ),
      );
    }

    // Create LessonModel with the vocabulary list
    LessonModel newLesson = LessonModel(
      title: lessonTitle,
      description: lessonDescription,
      creator: 'User',
      vocabulary: vocabularyList,
      dateCreate: DateTime.now().toString(),
    );

    dev.log(newLesson.title);
  }

  @override
  void dispose() {
    for (var form in numberForms) {
      form['termController'].dispose();
      form['definitionController'].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const CreateVocabularyBar(),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Chủ đề, chương, đơn vị',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black87),
                    ),
                  ),
                  onChanged: (value) {
                    updateLessonInfo(value, lessonDescription);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  'Tiêu đề',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF646363)),
                ),
              ),
              if (_showTextField)
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Thông tin mô tả',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                    ),
                    onChanged: (value) {
                      updateLessonInfo(lessonTitle, value);
                    },
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _showTextField = !_showTextField;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _showTextField ? '- Mô tả' : '+ Mô tả',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundColor,
                  ),
                ),
              ),
            ),
          ),
          for (int i = 0; i < numberForms.length; i++)
            Dismissible(
              key: Key(numberForms[i]['termController'].text + i.toString()), // Use a unique key
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  numberForms.removeAt(i);
                });
              },
              background: Container(
                color: AppColors.background,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: numberForms[i]['termController'],
                            onSubmitted: (value) => changeTrans(i, value),
                            decoration: const InputDecoration(
                              labelText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: const Text(
                            'Thuật ngữ',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF646363)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            controller: numberForms[i]['definitionController'],
                            readOnly: true, // Make it read-only
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: const Text(
                            'Định nghĩa',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF646363)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            numberForms.add({
              'term': '',
              'definition': '',
              'termController': TextEditingController(),
              'definitionController': TextEditingController(),
            });
          });
        },
      ),
    );
  }
}
