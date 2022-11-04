import 'package:flutter/material.dart';
import 'package:workouterapp/pages/login_page.dart';
import 'package:workouterapp/pages/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageStage();
}

class _AuthPageStage extends State<AuthPage> {
  // show the login page
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      //reverse of the above
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // User? get currentUser => _firebaseAuth.currentUser;

  // Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Future<void> sendPasswordResetEmail({
  //   required String email,
  // }) async {
  //   await _firebaseAuth.sendPasswordResetEmail(email: email);
  // }

  // Future<void> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await _firebaseAuth.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  // Future<void> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await _firebaseAuth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }

  // Future<void> signOut() async {
  //   await _firebaseAuth.signOut();
  // }

