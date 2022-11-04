import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _controllerEmail = TextEditingController();

  @override
  void dispose() {
    _controllerEmail.dispose();
    super.dispose();
  }

  // function to reset password
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controllerEmail.text);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Reset link sent!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[500],
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Enter your Email to get a reset link',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        )),
                  ),
                )),
            SizedBox(height: 10),
            Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0)),
              clipBehavior: Clip.antiAlias,
              child: MaterialButton(
                  height: 50,
                  elevation: 0,
                  onPressed: passwordReset,
                  color: Colors.grey[600],
                  child: Text('Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ))),
            )
          ],
        ));
  }
}
