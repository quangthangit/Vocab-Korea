import 'package:flutter/material.dart';
import 'package:vocabkpop/components/ResultCard.dart';
import 'package:vocabkpop/components/ResultChart.dart';
import 'package:vocabkpop/models/ChartModel.dart';
import '../../app_colors.dart';
import 'package:vocabkpop/widget/bar/ResultBar.dart';
import '../../models/StudyResultModel.dart';

class StudyResultPage extends StatelessWidget {
  final StudyResultModel studyResultModel;
  const StudyResultPage({super.key, required this.studyResultModel});

  @override
  Widget build(BuildContext context) {
    final List<ChartModel> chartData = [
      ChartModel('Đúng', studyResultModel.correctAnswers.toDouble(), Colors.green),
      ChartModel('Sai', studyResultModel.wrongAnswers.toDouble(), const Color(0xFFF7C236)),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ResultBar(submit: () {}, title: "Kết quả học tập"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const LinearProgressIndicator(
              value: 1.0,
              backgroundColor: Color(0xFFD7DEE5),
              color: AppColors.iconColor,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  const ProgressInfo(),
                  const SizedBox(height: 10),
                  ResultChart(chartData: chartData, studyResultModel: studyResultModel),
                  const SizedBox(height: 20),
                  const NextSteps(),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Xem lại kết quả',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF526481)),
                    ),
                  ),
                  const SizedBox(height:20),
                  ...studyResultModel.listResultModel.map((result) => ResultCard(result: result)).toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProgressInfo extends StatelessWidget {
  const ProgressInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bạn đang tiến bộ',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 6,
              child: Text(
                'Tiếp theo, hãy ôn luyện các thuật ngữ bạn đã bỏ lỡ với chế độ học cho đến khi nắm chắc',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              flex: 4,
              child: Icon(Icons.cloudy_snowing, size: 70, color: Colors.amber),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Kết quả của bạn',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF526481)),
        ),
      ],
    );
  }
}

class NextSteps extends StatelessWidget {
  const NextSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNextStepCard('Làm bài kiểm tra mới', AppColors.backgroundColor, Icons.collections_bookmark, Colors.white),
        const SizedBox(height: 10),
        _buildNextStepCard('Xem lại thẻ ghi nhớ', Colors.white, Icons.file_copy_outlined, AppColors.backgroundColor),
      ],
    );
  }

  Widget _buildNextStepCard(String title, Color backgroundColor, IconData icon, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(color: iconColor == Colors.white ? Colors.white : Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
