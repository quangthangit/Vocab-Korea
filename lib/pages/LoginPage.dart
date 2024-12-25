import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocabkpop/services/loginWithSocialNetwork.dart';

class LoginPage extends StatelessWidget {
  final LoginWithSocialNetwork _auth = LoginWithSocialNetwork();

  Future<void> _handleLoginWithSocialNetwork(
      BuildContext context, String socialNetwork) async {
    User? user;
    switch (socialNetwork) {
      case "Google":
        user = await _auth.signInWithGoogle();
        break;
      case "Facebook":
      // Add Facebook login implementation here if needed
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mạng xã hội không hợp lệ')),
        );
        return;
    }

    if (user != null) {
      // Handle successful login here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thất bại')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Unification_flag_of_Korea.svg/800px-Unification_flag_of_Korea.svg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(

            ),
            const SizedBox(width: 50),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 200),
                    const Text('Chào mừng bạn đến với Vocab Korea',style: TextStyle(
                      fontSize: 35,fontWeight: FontWeight.w700,fontFamily: 'Lobster',color: Colors.black
                    ),),
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SocialLoginButton(
                            buttons: Buttons.Google,
                            onPressed: () {
                              _handleLoginWithSocialNetwork(context, "Google");
                            },
                          ),
                          SocialLoginButton(
                            buttons: Buttons.Facebook,
                            onPressed: () {
                              _handleLoginWithSocialNetwork(context, "Facebook");
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final Buttons buttons;
  final VoidCallback onPressed;

  const SocialLoginButton({
    required this.buttons,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
            ),
          ],
        ),
        child: SignInButton(
          buttons,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
