import 'package:flutter/material.dart';
import 'package:vocabkpop/models/StudyResultModel.dart';

class ResultSummary extends StatelessWidget {
  final StudyResultModel studyResultModel;

  const ResultSummary({super.key, required this.studyResultModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildResultRow('Đúng', studyResultModel.correctAnswers, Colors.green),
        const SizedBox(height: 20),
        _buildResultRow('Sai', studyResultModel.wrongAnswers, const Color(0xFFF7C236)),
      ],
    );
  }

  Widget _buildResultRow(String label, int value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        Center(
          child: Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Text("$value", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}