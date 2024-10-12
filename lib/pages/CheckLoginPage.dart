import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vocabkpop/pages/LoginPage.dart';
import 'package:vocabkpop/pages/MyHomePage.dart';

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
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
              color: Colors.white,
            ),
          );
        }
        return AnimatedSwitcher(
          duration: const Duration(seconds: 3),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: snapshot.hasData
              ? FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 500)),
            builder: (context, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    color: Colors.white,
                  ),
                );
              } else {
                return MyHomePage();
              }
            },
          )
              : LoginPage(),
        );
      },
    );
  }
}
