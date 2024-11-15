import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/pages/LoginPage.dart';
import 'package:vocabkpop/pages/MyHomePage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../app_colors.dart';

class CheckLoginPage extends StatefulWidget {
  @override
  _CheckLoginPageState createState() => _CheckLoginPageState();
}

class _CheckLoginPageState extends State<CheckLoginPage> {
  late Stream<User?> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: AppColors.backgroundColor,
                size: 50,
              ),
            ),
          );
        }

        return Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: snapshot.hasData
                  ? FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 2000)),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                          color: AppColors.backgroundColor,
                          size: 50,
                        ),
                      ),
                    );
                  } else {
                    return MyHomePage();
                  }
                },
              )
                  : FutureBuilder(
                future: Future.delayed(Duration(milliseconds: 1500)),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: LoadingAnimationWidget.threeRotatingDots(
                          color: AppColors.backgroundColor,
                          size: 50,
                        ),
                      ),
                    );
                  } else {
                    return LoginPage();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
