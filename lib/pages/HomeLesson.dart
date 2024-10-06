import 'package:flutter/material.dart';
import 'package:vocabkpop/widget/HomeLessonBar.dart';

class HomeLesson extends StatelessWidget {
  const HomeLesson({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView (
          children: [
            const HomeLessonBar(),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(vertical: 100),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Center(
                child: Text('사람',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('Trung cấp 3',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      SizedBox(width: 5,),
                      Text('user09217662',style: TextStyle(fontSize: 15,fontFamily: 'KayPhoDu',fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: 1,
                    height: 10,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20,),
                  Text('92 thuật ngữ',style: TextStyle(fontSize: 15,fontFamily: 'KayPhoDu',fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.bookmarks,color: Color(0xFF812AEF),),
                  SizedBox(width: 10,),
                  Text('Thẻ ghi nhớ',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.computer,color: Color(0xFF812AEF),),
                  SizedBox(width: 10,),
                  Text('Học',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.menu_book,color: Color(0xFF812AEF),),
                  SizedBox(width: 10,),
                  Text('Kiểm tra',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
              padding: EdgeInsetsDirectional.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Icon(Icons.save_rounded,color: Color(0xFF812AEF),),
                  SizedBox(width: 10,),
                  Text('Ghép thẻ',style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,top: 20,right: 20),
              padding: EdgeInsetsDirectional.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFF812AEF),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Center(
                      child: Text('Học hết ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Học hết ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
