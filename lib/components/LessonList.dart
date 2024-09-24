import 'package:flutter/material.dart';

class LessonList extends StatelessWidget {
  const LessonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
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
          Align(
            alignment: Alignment.centerLeft, 
            child: Icon(Icons.save),
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Trung cấp 1',style: TextStyle(fontSize: 25,fontFamily: 'Lobster')),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Icon(Icons.account_circle_outlined),
              SizedBox(width: 10,),
              Text('user09217662',style: TextStyle(fontSize: 20,fontFamily: 'Lobster'))
            ],
          )
        ],
      ),
    );
  }
}
