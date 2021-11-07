import 'dart:async';

import 'package:e_commerce_app/screens/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_app/shared/components/navigations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    navigateAndFinish(context: context, nextScreen: ObBoardingScreen());
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              gradient: LinearGradient(
                  colors: [Colors.blueGrey, Colors.grey, Colors.blue]),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/logo5.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'e commerce',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
