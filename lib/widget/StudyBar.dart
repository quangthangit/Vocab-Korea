import 'package:flutter/material.dart';

class StudyBar extends StatelessWidget {
  const StudyBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Color(0xFFF5F5F5),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.cancel_rounded,size: 30,color: Color(0xFF526481)),
          Row(
            children: [
              Icon(Icons.menu_book,size: 30,color: Color(0xFF526481)),
              SizedBox(width: 10,),
              Text('Học',style: TextStyle(color: Color(0xFF526481),fontSize: 20,fontWeight: FontWeight.bold),)
            ],
          ),
          Icon(Icons.settings,size: 30,color: Color(0xFF526481),)
        ],
      ),
    );
  }
}
