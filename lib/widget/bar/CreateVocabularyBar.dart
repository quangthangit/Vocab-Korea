import 'package:flutter/material.dart';

class CreateVocabularyBar extends StatelessWidget {
  const CreateVocabularyBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.arrow_back_ios_new)
        ),
        Text('Tạo học phần',style: TextStyle(fontWeight: FontWeight.bold),),
        Row(
          children: [
            Icon(Icons.settings),
            SizedBox(width: 10,),
            Icon(Icons.check)
          ],
        )
      ],
    );
  }
}
