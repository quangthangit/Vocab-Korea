import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';

class MatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.iconColor, size: 40),
              onPressed: () {

              },
            ),
            const Expanded(
              child: Text(
                'Ghép thẻ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.iconColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.iconColor, size: 40),
              onPressed: () {
                // Hành động khi nhấn nút cài đặt
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                child: Column( // Sử dụng Column để chứa nhiều widget bên trong Container
                  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung trong Column
                  children: [
                    const Text("Bạn đã sẵn sàng ?", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),),
                    const SizedBox(height: 20),
                    const Text("Ghép tất cả các thuật ngữ theo \n định nghĩa của chúng", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/gameMatch');
                      },
                      style: ElevatedButton.styleFrom(minimumSize: const Size(370, 60), backgroundColor: AppColors.backgroundColor, foregroundColor: Colors.white),
                      child: const Text("Bắt đầu chơi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}