import 'package:flutter/material.dart';
import 'package:vocabkpop/models/UserModel.dart';

class User extends StatelessWidget {
  final UserModel userModel;
  final String creator;

  const User({super.key, required this.userModel, required this.creator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          const CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage('https://d1hjkbq40fs2x4.cloudfront.net/2017-08-21/files/landscape-photography_1645-t.jpg'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              userModel.id == creator
                  ? "${userModel.username} ( Người tạo )"
                  : userModel.username,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: userModel.id == creator ? Colors.blue : null,
                fontFamily: 'Lobster'
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}