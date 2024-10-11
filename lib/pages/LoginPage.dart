import 'package:flutter/material.dart';
import 'package:vocabkpop/app_colors.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vocabkpop/services/loginWithSocialNetwork.dart';


class LoginPage extends StatelessWidget {

  final LoginWithSocialNetwork _auth = LoginWithSocialNetwork();

  Future<void> _handleLoginWithSocialNetwork(BuildContext context, String socialNetwork) async {
    User? user;
    switch (socialNetwork) {
      case "Google":
        user = await _auth.signInWithGoogle();
        break;
      case "Facebook":
         user = await _auth.signInWithFacebook();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mạng xã hội không hợp lệ')),
        );
        return;
    }

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${user.tenantId}')),
      );
      Navigator.pushNamed(context, "/myhomepage");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng nhập thất bại')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 40, color: AppColors.iconColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 370,
                child: const Text(
                  'Quickly log in with',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              SocialLoginButton(
                buttons: Buttons.Google,
                onPressed: ()  {
                  _handleLoginWithSocialNetwork(context, "Google");
                },
              ),
              SocialLoginButton(
                buttons: Buttons.Email,
                onPressed: () {
                  // Handle Email login
                },
              ),
              SocialLoginButton(
                buttons: Buttons.Facebook,
                onPressed: () {
                  _handleLoginWithSocialNetwork(context, "Facebook");
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'or login with your email or username',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email or username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {

                  },
                  child: RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Forgot ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'username ',
                          style: TextStyle(color: AppColors.backgroundColor),
                        ),
                        TextSpan(
                          text: 'or ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'password',
                          style: TextStyle(color: AppColors.backgroundColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15),
                ),
                onPressed: () {
                  // Handle email/password login
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  class SocialLoginButton extends StatelessWidget {
  final Buttons buttons;
  final VoidCallback onPressed;

  SocialLoginButton({
    required this.buttons,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 370,
        height: 50,
        child: SignInButton(
          buttons,
          onPressed: onPressed,
        ),
      ),
    );
  }

}
