import 'package:flutter/material.dart';

class ClassRoom extends StatelessWidget {
  const ClassRoom({super.key});

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
            child: Text('21KIT',style: TextStyle(fontSize: 20,fontFamily: 'Lobster')),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Lớp học tiếng hàn VKU',style: TextStyle(fontSize: 20,fontFamily: 'Lobster')),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(Icons.collections_bookmark_outlined),
                  SizedBox(width: 10,),
                  Text('15 học phần',style: TextStyle(fontSize: 18,fontFamily: 'Lobster'))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.supervisor_account),
                  SizedBox(width: 10,),
                  Text('105 thành viên',style: TextStyle(fontSize: 18,fontFamily: 'Lobster'))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
