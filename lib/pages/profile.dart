import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workouterapp/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot_pw_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  // final docUser = FirebaseFirestore.instance.collection('users').doc();
  // // final docUserId = docUser.id;

  // Stream<List<User>> readUsers() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs.map((doc) => doc.data()).profilePage());

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> completeProfile(String firstName, String lastName, int age,
      int weight, String email) async {
    await FirebaseFirestore.instance.collection('Profiles').add({
      'First Name': firstName,
      'Last Name': lastName,
      'Age': age,
      'Weight': weight,
      'Email': email,
    });
  }

  String? errorMessage = '';

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _userUid() {
    return Text(user.email ?? 'User email',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ));
  }

  Widget _resetPassword() {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        height: 50,
        color: Colors.blueGrey,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ForgotPasswordPage();
          }));
        },
        child: Text('Forgot Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            )),
      ),
    );
  }

  Widget _signOutButton() {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
      clipBehavior: Clip.antiAlias,
      child: MaterialButton(
        height: 50,
        color: Colors.blueGrey,
        onPressed: signOut,
        child: const Text('Sign Out',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
      ),
    );
  }

  Widget _smallbox() {
    return const SizedBox(height: 10);
  }

  Widget _icon() {
    return Icon(
      Icons.person_outlined,
      size: 80,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/Profilepic-pana.png'),
              _smallbox(),
              _userUid(),
              _smallbox(),
              _smallbox(),
              _resetPassword(),
              _smallbox(),
              _smallbox(),
              _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
