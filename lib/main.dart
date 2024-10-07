import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabkpop/pages/HomeLesson.dart';
import 'package:vocabkpop/pages/HomePage.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;
import "package:curved_navigation_bar/curved_navigation_bar.dart" as curved_navigation_bar;
import 'package:vocabkpop/pages/LibraryPage.dart';
import 'package:vocabkpop/widget/AddForm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: app_color.AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routes: {
        '/homeLesson': (context) => HomeLesson(),
      },
      home: const HomeLesson(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomePages(),
    const LibraryPage(),
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
        return const AddForm();
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
        physics: const ClampingScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: curved_navigation_bar.CurvedNavigationBar(
        color: app_color.AppColors.backgroundColor,
        backgroundColor: Colors.transparent,
        height: 50,
        items: const [
          Icon(Icons.home_filled, color: Colors.white, size: 25),
          Icon(Icons.folder_copy_rounded, color: Colors.white, size: 25),
          Icon(Icons.add, color: Colors.white, size: 25),
          Icon(Icons.add_chart, color: Colors.white, size: 25),
          Icon(Icons.account_circle, color: Colors.white, size: 25),
        ],
        onTap: _onNavBarTap,
      ),
    );
  }
}
