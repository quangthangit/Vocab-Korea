import 'package:flutter/material.dart';
import 'package:vocabkpop/components/ClassRoom.dart';
import 'package:vocabkpop/components/LessonList.dart';
import 'package:vocabkpop/components/VocabularyLesson.dart';
import 'package:vocabkpop/widget/HomeBar.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HomeBar(),
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Học phần',
                      style: TextStyle(fontSize: 20, fontFamily: 'Lobster',fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Xem tất cả',
                      style: TextStyle(fontSize: 15,color: app_color.AppColors.backgroundColor, fontFamily: 'Lobster',fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              VocabularyLesson(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thư mục',
                      style: TextStyle(fontSize: 20, fontFamily: 'Lobster',fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Xem tất cả',
                      style: TextStyle(fontSize: 15,color: app_color.AppColors.backgroundColor, fontFamily: 'Lobster',fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              LessonList(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Lớp học',
                      style: TextStyle(fontSize: 20, fontFamily: 'Lobster',fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Xem tất cả',
                      style: TextStyle(fontSize: 15,color: app_color.AppColors.backgroundColor, fontFamily: 'Lobster',fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ClassRoom(),
            ],
          ),
        ],
      ),
    );
  }
}
