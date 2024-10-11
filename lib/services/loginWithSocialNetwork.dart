import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class LoginWithSocialNetwork {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        await _saveUserToFirestore(user);
      }
      return user;
    } catch (e) {
      print('Lỗi đăng nhập Google: $e');
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      await signOut();
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final String? token = result.accessToken?.token;
        if (token != null) {
          final OAuthCredential credential = FacebookAuthProvider.credential(token);
          UserCredential userCredential = await _auth.signInWithCredential(credential);
          User? user = userCredential.user;
          if (user != null) {
            await _saveUserToFirestore(user);
          }
          return user;
        }
      } else {
        print('Đăng nhập Facebook thất bại: ${result.status}');
        return null;
      }
    } catch (e) {
      print('Lỗi đăng nhập Facebook: ${e.toString()}');
      return null;
    }
  }



  Future<void> _saveUserToFirestore(User user) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(
        user.uid);
    final userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      await userRef.set({
        'username': user.displayName,
        'email': user.email,
        'first_login': FieldValue.serverTimestamp(),
        'created_at': FieldValue.serverTimestamp(),
      });
    } else {
      await userRef.update({
        'last_login': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
