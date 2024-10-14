import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vocabkpop/models/UserModel.dart';
import 'package:vocabkpop/services/UserService.dart';


class LoginWithSocialNetwork {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UserService _userService = UserService();

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


  Future<void> _saveUserToFirestore(User user) async {
    UserModel _userModel = UserModel(
      id: user.uid,
      username: user.displayName ?? '',
      email: user.email ?? '',
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'username': _userModel.username,
      'email': _userModel.email,
      'created_at': _userModel.createdAt,
      'last_login': _userModel.lastLogin,
    });
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
