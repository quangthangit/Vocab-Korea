import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/LessonModel.dart';
import 'package:vocabkpop/pages/StudyQuizPage.dart';
import 'package:vocabkpop/widget/bar/StudyBar.dart';

class StudyPage extends StatefulWidget {
  final LessonModel lessonModel;
  const StudyPage({super.key, required this.lessonModel});

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  bool isCorrectWrong = false;
  bool isMultipleChoice = false;
  bool isSelfStudy = false;

  void _onSwitchChanged(String switchType) {
    setState(() {
      isCorrectWrong = false;
      isMultipleChoice = false;
      isSelfStudy = false;

      if (switchType == 'correctWrong') {
        isCorrectWrong = true;
      } else if (switchType == 'multipleChoice') {
        isMultipleChoice = true;
      } else if (switchType == 'selfStudy') {
        isSelfStudy = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: const StudyBar(),
      ),
      body: Column(
        children: [
          const LinearProgressIndicator(
            value: 100,
            backgroundColor: Color(0xFFD7DEE5),
            color: AppColors.iconColor,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.lessonModel.title,
                          style: const TextStyle(
                            color: Color(0xFF526481),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const Text(
                          'Thiết lập bài kiểm tra',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.save_as_sharp,
                      color: Colors.amber,
                      size: 50,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Số câu hỏi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${widget.lessonModel.vocabulary.length} câu',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trả lời bằng :',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Thuật ngữ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Đúng / Sai',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Switch(
                      value: isCorrectWrong,
                      onChanged: (bool value) {
                        _onSwitchChanged('correctWrong');
                      },
                      inactiveTrackColor: const Color(0xFF919BB4),
                      activeTrackColor: const Color(0xFF4254FE),
                      activeColor: Colors.lightBlue,
                      thumbColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Trắc nghiệm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Switch(
                      value: isMultipleChoice,
                      onChanged: (bool value) {
                        _onSwitchChanged('multipleChoice');
                      },
                      inactiveTrackColor: const Color(0xFF919BB4),
                      activeTrackColor: const Color(0xFF4254FE),
                      activeColor: Colors.lightBlue,
                      thumbColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tự luận',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Switch(
                      value: isSelfStudy,
                      onChanged: (bool value) {
                        _onSwitchChanged('selfStudy');
                      },
                      inactiveTrackColor: const Color(0xFF919BB4),
                      activeTrackColor: const Color(0xFF4254FE),
                      activeColor: Colors.lightBlue,
                      thumbColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey;
                          }
                          return Colors.white;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            if (isMultipleChoice == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizWidget(
                    vocabularyModel: widget.lessonModel.vocabulary,
                  ),
                ),
              );
            }
          },

          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Bắt đầu',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
