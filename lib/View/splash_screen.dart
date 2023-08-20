import 'dart:async';


import 'package:covid/View/world_states.dart';
import 'package:flutter/material.dart';


import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(milliseconds: 1500), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        const Duration(seconds: 4),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WorldStates())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: const SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image(
                      // image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/94/Coronavirus._SARS-CoV-2.png'),
                      image: AssetImage('images/virus19.png'),
                    ),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 1.5 * math.pi,
                    child: child,
                  );
                }),
            const SizedBox(
              // height: MediaQuery.of(context).size.height * 01,
              height: 50,
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  'Covid-19 \nTracker',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
