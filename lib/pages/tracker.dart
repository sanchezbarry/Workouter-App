import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workouterapp/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  int timeLeft = 60;

  void startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(timeLeft == 0 ? 'D O N E' : timeLeft.toString(),
            style: TextStyle(
              fontSize: 75,
            )),
        SizedBox(height: 20),
        Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
              height: 50,
              onPressed: startCountdown,
              child: Text('S T A R T',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              color: Colors.blueGrey),
        )
      ],
    )));
  }
}
