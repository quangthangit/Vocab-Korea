import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:vocabkpop/widget/bar/CreateBar.dart';
import 'package:vocabkpop/widget/bar/ResultMatchBar.dart';

class ResultMatchPage extends StatelessWidget {
  final double seconds;
  final String idLesson;

  const ResultMatchPage({
    super.key,
    required this.seconds,
    required this.idLesson,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: ResultMatchbar(submit: () {}, title: 'Ghép thẻ'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: 100,
              backgroundColor: const Color(0xFFD7DEE5),
              color: AppColors.iconColor,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Center(
                      child: const Text(
                        'Hoàn thành trong',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        '${seconds.toStringAsFixed(1)} giây',
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: const Text(
                        'Kỉ lục cá nhân là 14.4 giây',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildRankingItem(1, seconds),
                    const SizedBox(height: 20),
                    Center(
                      child: const Text(
                        'BẢNG XẾP HẠNG',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    for (int i = 1; i <= 4; i++) _buildRankingItem(i, seconds),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingItem(int rank, double seconds) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            color: Colors.blue,
            child: Text(
              '$rank',
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            '${seconds.toStringAsFixed(1)} giây',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const Row(
            children: [
              Icon(Icons.account_circle),
              SizedBox(width: 5),
              Text(
                'user232723',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'KayPhoDu'),
              ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
