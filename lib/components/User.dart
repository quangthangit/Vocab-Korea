import 'package:flutter/material.dart';
import 'package:vocabkpop/models/UserModel.dart';

class User extends StatelessWidget {
  final UserModel userModel;
  const User({super.key, required this.userModel});

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
      child: Row(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.account_circle,size: 20,),
          ),
          const SizedBox(width: 10,),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("${userModel.username}",style: TextStyle(fontSize: 20,fontFamily: 'Lobster')),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}