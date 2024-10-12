import 'package:flutter/material.dart';
import 'package:vocabkpop/models/ClassModel.dart';

class ClassRoom extends StatelessWidget {
  final ClassModel classModel;
  const ClassRoom({super.key, required this.classModel});

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
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(classModel.name,style: const TextStyle(fontSize: 15,fontFamily: 'Lobster')),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Lớp học tiếng hàn VKU',style: TextStyle(fontSize: 12,fontFamily: 'Lobster')),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Row(
                children: [
                  Icon(Icons.collections_bookmark_outlined),
                  SizedBox(width: 10,),
                  Text('15 học phần',style: TextStyle(fontSize: 15,fontFamily: 'Lobster'))
                ],
              ),
              Row(
                children: [
                  Icon(Icons.supervisor_account),
                  const SizedBox(width: 10,),
                  Text('${classModel.idMember.length}',style: TextStyle(fontSize: 15,fontFamily: 'Lobster'))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
