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

  void _startAnimation() {
    controller.forward();
  }

  void _pauseAnimation() {
    controller.stop();
  }

  void _restartAnimation() {
    controller.reset();
    //controller.forward();
  }

  void _reverseAnimation() {
    if (controller.status == AnimationStatus.forward ||
        controller.status == AnimationStatus.completed) {
      controller.reverse();
    } else {
      controller.forward();
    }
    //controller.reverse();
  }

  @override
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _startAnimation,
                child: const Icon(Icons.play_arrow),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: _pauseAnimation,
                child: const Icon(Icons.pause),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: _reverseAnimation,
                child: const Icon(Icons.sync),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                onPressed: _restartAnimation,
                child: const Icon(Icons.replay),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

}
