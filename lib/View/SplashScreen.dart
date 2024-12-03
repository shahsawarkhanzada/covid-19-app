import 'dart:async';

import 'package:covid_19_app/View/worldState.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WorldStateScreen())));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, Widget? child) {
              return Transform.scale(
                scaleX: 2.5,
                scaleY: 2.5,
                child: child,
              );
            },
            child: Text(
              'Covid-19',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 37, 219)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          AnimatedBuilder(
              animation: animationController,
              child: const Center(
                child: SizedBox(
                    height: 135,
                    width: 135,
                    child: Image(image: AssetImage('images/virus4.png'))),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: animationController.value * 2.0 * math.pi,
                  child: child,
                );
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, Widget? child) {
              return Transform.scale(
                scaleX: 2.5,
                scaleY: 2.5,
                child: child,
              );
            },
            child: Text(
              'Tracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 38, 67, 235)),
            ),
          )
        ],
      ),
    );
  }
}
