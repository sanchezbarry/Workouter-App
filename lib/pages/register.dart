// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers to listen to user input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();

  //dispose of controllers when not using to help memory management
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  //create user function
  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      addDetails(
        _firstNameController.text,
        _lastNameController.text,
        int.parse(_ageController.text),
        int.parse(_weightController.text),
        _emailController.text,
      );
    }
  }

  Future addDetails(String firstName, String lastName, int age, int weight,
      String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'First Name': firstName,
      'Last Name': lastName,
      'Age': age,
      'Weight': weight,
      'Email': email,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text == _confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.run_circle,
                      size: 75,
                    ),

                    SizedBox(height: 10),

                    Text('Workouter!',
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        )),

                    SizedBox(height: 10),
                    Text(
                      'Your journey to a better you starts here.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 30),

                    //firstname
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'First Name',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //lastname
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Last Name',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //age
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _ageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Age',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //weight
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _weightController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Weight (KG)',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //email
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email Address',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    //password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //confirm password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: signUp,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Text('Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ))),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // link to register page
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('A Workouter already?'),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Text(' Login now.',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
