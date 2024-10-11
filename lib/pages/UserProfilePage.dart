import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
class UserProfilePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('${_auth.currentUser?.photoURL}'),
                      ),
                      SizedBox(height: 10,),
                      Text('${_auth.currentUser?.displayName}',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFFD9D9D9),
                    width: 2,
                  ),
                ),
                margin: EdgeInsets.all(20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings_outlined,color: AppColors.backgroundColor),
                        SizedBox(width: 10,),
                        Text('Your Settings',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 140),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _auth.signOut();
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
