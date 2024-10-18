import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/models/VocabularyModel.dart';
import 'package:vocabkpop/widget/bar/StudyEssayBar.dart';

class StudyEssayPage extends StatefulWidget {
  final List<VocabularyModel> vocabularyModel;
  const StudyEssayPage({super.key, required this.vocabularyModel});

  @override
  _StudyEssayPageState createState() => _StudyEssayPageState();
}

class _StudyEssayPageState extends State<StudyEssayPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _answerController = TextEditingController();
  int _currentIndex = 0;
  late PageController _pageController;
  late List<VocabularyModel> _vocabularyList;
  bool _isAnswerWrong = false;
  bool _isAnswerCorrect = false;
  bool _showAnswer = false;
  late String _answer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void dispose() {
    _answerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _vocabularyList = widget.vocabularyModel;
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();
  }

  void _goToNextPage() {
    _animationController.reset();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _resetState();
    _animationController.forward();
  }

  void _resetState() {
    _answerController.clear();
    _isAnswerWrong = false;
    _isAnswerCorrect = false;
    _showAnswer = false;
    _answer = "";
  }

  void _validateAnswer(String correctAnswer, String userAnswer) {
    if (correctAnswer != userAnswer) {
      setState(() {
        _isAnswerWrong = true;
        _showAnswer = true;
        _answer = userAnswer;
      });
    } else {
      setState(() {
        _isAnswerCorrect = true;
        _showAnswer = true;
        _answer = userAnswer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (_currentIndex + 1) / widget.vocabularyModel.length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: StudyEssayBar(
          currentIndex: _currentIndex,
          vocabularyList: widget.vocabularyModel,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFFD7DEE5),
                color: AppColors.iconColor,
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _vocabularyList.length,
                        itemBuilder: (context, index) {
                          final vocabulary = _vocabularyList[index];
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Column(
                              key: ValueKey(vocabulary),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      vocabulary.vietnamese,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                if (_isAnswerCorrect)
                                  _buildCorrectAnswerDisplay(vocabulary)
                                else if (!_isAnswerWrong)
                                  _buildAnswerInput(vocabulary)
                                else
                                  _buildWrongAnswerDisplay(vocabulary),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _showAnswer ? _buildNextButton() : null,
    );
  }

  Widget _buildAnswerInput(VocabularyModel vocabulary) {
    return Container(
      child: Column(
        children: [
          const Divider(color: Colors.grey, height: 2),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: (text) {
                    _validateAnswer(vocabulary.korean, text);
                  },
                  controller: _answerController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập đáp án',
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showAnswer = true;
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Không biết',
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey, height: 2),
        ],
      ),
    );
  }

  Widget _buildWrongAnswerDisplay(VocabularyModel vocabulary) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Học là cả một quá trình đừng nản!!',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        _buildFeedbackBox(Icons.close, Colors.red, _answer),
        _buildFeedbackBox(Icons.check, Colors.green, vocabulary.korean),
      ],
    );
  }

  Widget _buildCorrectAnswerDisplay(VocabularyModel vocabulary) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Câu trả lời của bạn đã đúng!',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
        _buildFeedbackBox(Icons.check, Colors.green, _answer)
      ],
    );
  }

  Widget _buildFeedbackBox(IconData icon, Color color, String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Icon(icon, color: color),
          ),
          Expanded(
            flex: 7,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(message),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 120),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _goToNextPage,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Câu tiếp theo',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
