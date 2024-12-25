import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../app_colors.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'Tiến độ học',
                    style: TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  SfCircularChart(
                    title: ChartTitle(
                      text: 'Thời gian học theo kỹ năng',
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    legend: const Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                    series: <PieSeries<_ChartData, String>>[
                      PieSeries<_ChartData, String>(
                        dataSource: _getChartData(),
                        xValueMapper: (_ChartData data, _) => data.category,
                        yValueMapper: (_ChartData data, _) => data.value,
                        dataLabelSettings: const DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SfCartesianChart(
                title: ChartTitle(
                  text: 'Tiến độ học theo thời gian',
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                legend: Legend(isVisible: true),
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                ),
                series: <LineSeries<_ChartData2, String>>[
                  LineSeries<_ChartData2, String>(
                    name: 'Bài học hoàn thành',
                    dataSource: _getChartData2(),
                    xValueMapper: (_ChartData2 data, _) => data.day,
                    yValueMapper: (_ChartData2 data, _) => data.lessons,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng số bài đã học',
                          style: TextStyle(fontSize: 15, fontFamily: 'Lobster'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '12',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng ngày đã học',
                          style: TextStyle(fontSize: 15, fontFamily: 'Lobster'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '7',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng số lần chơi mini game',
                          style: TextStyle(fontSize: 15, fontFamily: 'Lobster'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '12',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Số lớp học tham gia',
                          style: TextStyle(fontSize: 15, fontFamily: 'Lobster'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '7',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 35,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<_ChartData2> _getChartData2() {
    return [
      _ChartData2('Thứ 2', 3),
      _ChartData2('Thứ 3', 4),
      _ChartData2('Thứ 4', 2),
      _ChartData2('Thứ 5', 5),
      _ChartData2('Thứ 6', 3),
      _ChartData2('Thứ 7', 6),
      _ChartData2('CN', 4),
    ];
  }

  List<_ChartData> _getChartData() {
    return [
      _ChartData('Từ vựng', 40),
      _ChartData('Ngữ pháp', 30),
      _ChartData('Đọc hiểu', 20),
      _ChartData('Nghe', 10),
    ];
  }
}

class _ChartData {
  _ChartData(this.category, this.value);

  final String category;
  final double value;
}

class _ChartData2 {
  _ChartData2(this.day, this.lessons);

  final String day;
  final int lessons;
}
