import 'package:flutter/material.dart';
import 'package:vocabkpop/pages/ResultSearchPage.dart';
import 'package:vocabkpop/widget/bar/HomeBar.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  String _searchText = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HomeBar(),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thư mục',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lobster',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Xem tất cả',
                      style: TextStyle(
                        fontSize: 15,
                        color: app_color.AppColors.backgroundColor,
                        fontFamily: 'Lobster',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
