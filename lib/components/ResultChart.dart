import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vocabkpop/components/ResultSummary.dart';
import 'package:vocabkpop/models/ChartModel.dart';
import 'package:vocabkpop/models/StudyResultModel.dart';
import 'package:flutter/material.dart';

class ResultChart extends StatelessWidget {
  final List<ChartModel> chartData;
  final StudyResultModel studyResultModel;

  const ResultChart({super.key, required this.chartData, required this.studyResultModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCircularChart(
                legend: const Legend(isVisible: false),
                series: <DoughnutSeries<ChartModel, String>>[
                  DoughnutSeries<ChartModel, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartModel data, _) => data.x,
                    yValueMapper: (ChartModel data, _) => data.y,
                    pointColorMapper: (ChartModel data, _) => data.color,
                    dataLabelSettings: const DataLabelSettings(isVisible: false),
                    innerRadius: '80%',
                  ),
                ],
              ),
              Text(
                studyResultModel.totalQuestions > 0
                    ? '${((studyResultModel.correctAnswers / studyResultModel.totalQuestions) * 100).toStringAsFixed(1)}%'
                    : '0.0%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: ResultSummary(studyResultModel: studyResultModel),
        )
      ],
    );
  }
}
