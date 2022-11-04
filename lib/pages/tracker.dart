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

//set counter
  int setCounter = 0;

  void _increaseSets() {
    setState(() {
      setCounter++;
    });
  }

  void _decreaseSets() {
    if (setCounter > 0) {
      setState(() {
        setCounter--;
      });
    } else {
      setCounter = 0;
    }
  }

//rep counter
  int repCounter = 0;

  void _increaseReps() {
    setState(() {
      repCounter++;
    });
  }

  void _decreaseReps() {
    if (repCounter > 0) {
      setState(() {
        repCounter--;
      });
    } else {
      repCounter = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/Smartwatch-pana.png',
          height: 350,
        ),
        Text(timeLeft == 0 ? 'D O N E' : timeLeft.toString(),
            style: TextStyle(
              fontSize: 75,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 5),
        Material(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
              height: 50,
              onPressed: startCountdown,
              child: Text('R E S T',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              color: Colors.blueGrey),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 55.0),
              child: Text('Set Counter'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 55.0),
              child: Text('Rep Counter'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                      onTap: _decreaseSets,
                      child: Text('-',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                          ))),
                ),
                Text(setCounter.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 65,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                      onTap: _increaseSets,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Text('+',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            )),
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                      onTap: _decreaseReps,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text('-',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 45,
                            )),
                      )),
                ),
                Text(repCounter.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 65,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                      onTap: _increaseReps,
                      child: Text('+',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 45,
                          ))),
                )
              ],
            ),
          ],
        )
      ],
    )));
  }
}
