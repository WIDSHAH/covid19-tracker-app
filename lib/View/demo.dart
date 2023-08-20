import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        automaticallyImplyLeading: false,
        title: const Text("Flutter AnimatedBuilder Widget Demo"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: Image.asset("images/virus.png"),
          ),
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _controller.value * 2.2 * math.pi,
              child: child,
            );
          },
        ),
      ),
    );
  }
}