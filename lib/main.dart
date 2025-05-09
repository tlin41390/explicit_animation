import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({super.key});

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  void _restartAnimation() {
    controller.reset();
    controller.forward();
  }

  void _pauseAnimation() {
    controller.stop();
  }

  void _startAnimation() {
    controller.forward();
  }

  void _reverseAnimation() {
    controller.reverse();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: animation.value,
            width: animation.value,
            child: Image.asset('assets/images/capybara.jpg', fit: BoxFit.contain),
          ),
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: _restartAnimation,
              child: const Icon(Icons.replay),
            ),
            FloatingActionButton(
              onPressed: _startAnimation,
              child: const Icon(Icons.start),
            ),

            FloatingActionButton(
              onPressed: _pauseAnimation,
              child: const Icon(Icons.pause),
            ),

            FloatingActionButton(
              onPressed: _reverseAnimation,
              child: const Icon(Icons.replay),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
