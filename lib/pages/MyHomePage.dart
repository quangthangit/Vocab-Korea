import 'package:flutter/material.dart';
import 'package:vocabkpop/pages/HomePage.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;
import "package:curved_navigation_bar/curved_navigation_bar.dart" as curved_navigation_bar;
import 'package:vocabkpop/pages/LibraryPage.dart';
import 'package:vocabkpop/pages/UserProfilePage.dart';
import 'package:vocabkpop/widget/bottom_sheets/AddDataOptionsBottomSheet%20.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePages(),
    LibraryPage(),
    HomePages(),
    UserProfilePage(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNavBarTap(int index) {
    if (index == 2) {
      _showAddForm();
    } else {
      _pageController.jumpToPage(index);
      _onPageChanged(index);
    }
  }

  void _showAddForm() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const AddDataOptionsBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        pageSnapping: true,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: curved_navigation_bar.CurvedNavigationBar(
        color: app_color.AppColors.backgroundColor,
        backgroundColor: Colors.transparent,
        height: 50,
        items: const [
          Tooltip(
            message: 'Home',
            child: Icon(Icons.home_filled, color: Colors.white, size: 25),
          ),
          Tooltip(
            message: 'Library',
            child: Icon(Icons.folder_copy_rounded, color: Colors.white, size: 25),
          ),
          Tooltip(
            message: 'Add',
            child: Icon(Icons.add, color: Colors.white, size: 25),
          ),
          Tooltip(
            message: 'Stats',
            child: Icon(Icons.add_chart, color: Colors.white, size: 25),
          ),
          Tooltip(
            message: 'Profile',
            child: Icon(Icons.account_circle, color: Colors.white, size: 25),
          ),
        ],

        onTap: _onNavBarTap,
      ),
    );
  }
}