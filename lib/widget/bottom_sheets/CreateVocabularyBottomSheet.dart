import 'dart:developer' as dev;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/FolderModel.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/services/FolderService.dart';
import 'package:vocabkpop/services/LessonService.dart';
import 'package:vocabkpop/services/TranslationService.dart';
import 'package:vocabkpop/widget/bar/CreateBar.dart';

class CreateVocabularyBottomSheet extends StatefulWidget {
  final String? idFolder;
  const CreateVocabularyBottomSheet({super.key, this.idFolder});

  @override
  _CreateVocabularyBottomSheetState createState() => _CreateVocabularyBottomSheetState();
}

class _CreateVocabularyBottomSheetState extends State<CreateVocabularyBottomSheet> {
  bool _showDescriptionField = false;
  String lessonTitle = '';
  String lessonDescription = '';
  List<VocabularyModel> vocabularyList = [];
  final LessonService _lessonService = LessonService();
  final FolderService _folderService = FolderService();
  final TranslationService _translationService = TranslationService();

  List<Map<String, dynamic>> numberForms = [
    {
      'termController': TextEditingController(),
      'definitionController': TextEditingController(),
    }
  ];

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
      numberForms[index]['definitionController'].text = translatedText;
    });
  }

  Future<void> _submit() async {
    if (lessonTitle.isEmpty) {
      _showSnackBar('Vui lòng không để trống dữ liệu!');
      return;
    }

    for (var form in numberForms) {
      String term = form['termController'].text;
      String definition = form['definitionController'].text;
      if (term.isNotEmpty && definition.isNotEmpty) {
        vocabularyList.add(VocabularyModel(
          korean: term,
          vietnamese: definition,
          star: 0,
        ));
      }
    }

    LessonModel newLesson = LessonModel(
      title: lessonTitle,
      description: lessonDescription,
      creator: FirebaseAuth.instance.currentUser!.uid,
      vocabulary: vocabularyList,
      dateCreate: DateTime.now(),
      idMember: [
        FirebaseAuth.instance.currentUser!.uid,
      ],
    );

    bool isSuccess;

    if (widget.idFolder != null) {
      isSuccess = await _createLessonWithFolder(newLesson);
    } else {
      isSuccess = await _lessonService.createLesson(newLesson);
    }
    _showSnackBar(isSuccess ? 'Thêm bài học thành công' : 'Thêm bài học thất bại');
    reset();
  }

  Future<bool> _createLessonWithFolder(LessonModel newLesson) async {
    Map<String, dynamic> result = await _lessonService.createLessonWithFolder(newLesson);

    if (result['success'] && result['id'] != null) {
      FolderModel? folderModel = await _folderService.getFolderById(widget.idFolder);
      folderModel?.lessonList.add(result['id']);
      await _folderService.updateFolder(widget.idFolder, folderModel!);
      return true;
    }

    return false;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void reset() {
    lessonTitle = '';
    lessonDescription = '';
    vocabularyList.clear();

    for (var form in numberForms) {
      form['termController'].dispose();
      form['definitionController'].dispose();
    }
    numberForms.clear();
    numberForms.add({
      'termController': TextEditingController(),
      'definitionController': TextEditingController(),
    });

    setState(() {
      _showDescriptionField = false;
    });
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
        title: CreateBar(
            submit: _submit,
            title: 'Tạo bài học',
        ),
      ),
      body: ListView(
        children: [
          _buildLessonTitleField(),
          _buildDescriptionToggle(),
          if (_showDescriptionField) _buildLessonDescriptionField(),
          ..._buildVocabularyForms(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.backgroundColor,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _addVocabularyForm,
      ),
    );
  }

  Widget _buildLessonTitleField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
        onChanged: (value) => updateLessonInfo(value, lessonDescription),
      ),
    );
  }

  Widget _buildDescriptionToggle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showDescriptionField = !_showDescriptionField;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            _showDescriptionField ? '- Mô tả' : '+ Mô tả',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonDescriptionField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
        onChanged: (value) => updateLessonInfo(lessonTitle, value),
      ),
    );
  }

  List<Widget> _buildVocabularyForms() {
    return numberForms.asMap().entries.map((entry) {
      int i = entry.key;
      var form = entry.value;
      return Dismissible(
        key: UniqueKey(),
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
        child: _buildVocabularyForm(form, i),
      );
    }).toList();
  }

  Widget _buildVocabularyForm(Map<String, dynamic> form, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTermField(form, index),
          _buildDefinitionField(form),
        ],
      ),
    );
  }

  Widget _buildTermField(Map<String, dynamic> form, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: form['termController'],
            onSubmitted: (value) => changeTrans(index, value),
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'Thuật ngữ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF646363)),
          ),
        ),
      ],
    );
  }

  Widget _buildDefinitionField(Map<String, dynamic> form) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: form['definitionController'],
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'Định nghĩa',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF646363)),
          ),
        ),
      ],
    );
  }

  void _addVocabularyForm() {
    setState(() {
      numberForms.add({
        'termController': TextEditingController(),
        'definitionController': TextEditingController(),
      });
    });
  }
}
