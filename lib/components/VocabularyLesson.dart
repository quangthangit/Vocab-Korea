import 'package:flutter/material.dart';

class VocabularyLesson extends StatelessWidget {
  const VocabularyLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
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
        children: [
          Row(
            children: [
              Text('Bài 5',style: TextStyle(fontSize: 20,fontFamily: 'Lobster'),),
              SizedBox(width: 10,),
              Text('Trung cấp 1',style: TextStyle(fontSize: 20,fontFamily: 'Lobster'))
            ],
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('36 Thuật ngữ', style: TextStyle(fontSize: 15, fontFamily: 'Lobster')),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Icon(Icons.account_circle_outlined),
              SizedBox(width: 5,),
              Text('user09217662',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontFamily: 'KayPhoDu'))
            ],
          )
        ],
      ),
    );
  }
}
