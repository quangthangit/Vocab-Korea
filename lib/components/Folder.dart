import 'package:flutter/material.dart';
import 'package:vocabkpop/models/FolderModel.dart';

class Folder extends StatelessWidget {
  final FolderModel folderModel;
  const Folder({super.key, required this.folderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.save,size: 20,),
          ),
          const SizedBox(height: 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("${folderModel.title}",style: TextStyle(fontSize: 20,fontFamily: 'Lobster')),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}