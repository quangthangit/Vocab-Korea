import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabkpop/models/LoginHistoryModel.dart';
import 'package:vocabkpop/pages/HomePage.dart';
import 'package:vocabkpop/app_colors.dart' as app_color;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:vocabkpop/pages/LibraryPage.dart';
import 'package:vocabkpop/pages/ProgressPage.dart';
import 'package:vocabkpop/pages/UserProfilePage.dart';
import 'package:vocabkpop/services/LoginHistoryService.dart';
import 'package:vocabkpop/widget/bottom_sheets/AddDataOptionsBottomSheet%20.dart';

import '../app_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final LoginHistoryService loginHistory = LoginHistoryService();

  @override
  void initState() {
    super.initState();
    _checkAndUpdateLoginHistory();
    _setStatusBarStyle();
  }

  void _setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  Future<void> _checkAndUpdateLoginHistory() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    try {
      LoginHistoryModel? history = await loginHistory.getLoginHistoryModelByUser(userId);

      if (history != null) {
        bool isTodayLogged = history.listDateTime.any((dateTime) =>
        dateTime.year == DateTime.now().year &&
            dateTime.month == DateTime.now().month &&
            dateTime.day == DateTime.now().day);

        if (!isTodayLogged) {
          history.listDateTime.add(DateTime.now());
          await loginHistory.updateLoginHistory(history.id, history);
        }
      } else {
        await loginHistory.createLoginHistory(LoginHistoryModel(
          idUser: userId,
          listDateTime: [DateTime.now()],
        ));
      }
    } catch (e) {
      print('Error updating login history: $e');
    }
  }

  final List<Widget> _pages = [
    HomePages(),
    LibraryPage(),
    HomePages(),
    ProgressPage(),
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
        ),
        bottomNavigationBar: CurvedNavigationBar(
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
      ),
    );
  }
}
