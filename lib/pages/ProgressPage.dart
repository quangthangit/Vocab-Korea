import 'package:flutter/material.dart';

import '../app_colors.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tiến độ học',
                      style: TextStyle(fontSize: 25, fontFamily: 'Lobster'),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
