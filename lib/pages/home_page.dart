// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:workouterapp/auth/auth_page.dart';
import 'package:workouterapp/pages/tracker.dart';
import 'package:workouterapp/pages/workout_builder.dart';
import 'package:workouterapp/pages/profile.dart';
import 'package:workouterapp/read%20data/get_user_name.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  //pages
  final List<Widget> _pages = [TrackerPage(), WorkoutBuilerPage(), Profile()];

  //
  int _selectedIndex = 0;

  //navigate to page
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> profileInfo = [];

  //get profile info
  Future getProfileInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              profileInfo.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext content) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Workouter', style: TextStyle(fontSize: 18)),
          actions: [
            GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.logout),
                ))
          ],
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              padding: EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.timer_outlined,
                  text: 'Timer',
                ),
                GButton(
                  icon: Icons.run_circle_outlined,
                  text: 'Workout',
                ),
                GButton(icon: Icons.person_outline_rounded, text: 'Profile'),
              ],
            ),
          ),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: FutureBuilder(
          //           future: getProfileInfo(),
          //           builder: (context, snapshot) {
          //             return ListView.builder(
          //               itemCount: profileInfo.length,
          //               itemBuilder: (context, index) {
          //                 return Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: ListTile(
          //                     title: GetUserName(documentId: profileInfo[index]),
          //                     tileColor: Colors.grey[200],
          //                   ),
          //                 );
          //               },
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ));
  }
}

//   final user = FirebaseAuth.instance.currentUser;

//   Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();

//   }

//   Widget _title() {
//     return const Text('Welcome back!');
//   }

//   // Widget _userUid() {
//   //   return Text(user.email!);
//   // }

//   Widget _signOutButton() {
//     return ElevatedButton(
//       onPressed: signOut,
//       child: const Text('Sign Out'),
//     );
//   }

//   int _selectedIndex = 0;

//   // void _navigateBottomBar(int index) {
//   //   setState(() {
//   //     _selectedIndex = index;
//   //   });
//   // }

//   final List<Widget> _pages = [TrackerPage(), WorkoutBuilerPage(), Profile()];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:
//             // _pages[_selectedIndex],
//             Container(
//           height: double.infinity,
//           width: double.infinity,
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // _userUid(),
//               _signOutButton(),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           color: Colors.black,
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
//             child: GNav(
//               backgroundColor: Colors.black,
//               color: Colors.white,
//               activeColor: Colors.white,
//               tabBackgroundColor: Colors.grey.shade800,
//               gap: 8,
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//               padding: EdgeInsets.all(16),
//               tabs: const [
//                 GButton(
//                   icon: Icons.run_circle_outlined,
//                   text: 'Workout',
//                 ),
//                 GButton(
//                   icon: Icons.note_add_outlined,
//                   text: 'Logs',
//                 ),
//                 GButton(icon: Icons.person_outline_rounded, text: 'Profile'),
//               ],
//             ),
//           ),
//         ));
//   }
// }
