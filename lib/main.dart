import 'package:flutter/material.dart';

void main() => runApp(const ExplicitAnimationDemoApp());

enum AnimationDirection { forward, reverse }

enum AnimationPlayState { playing, paused }

class ExplicitAnimationDemoApp extends StatefulWidget {
  const ExplicitAnimationDemoApp({super.key});

  @override
  State<ExplicitAnimationDemoApp> createState() =>
      _ExplicitAnimationDemoAppState();
}

class _ExplicitAnimationDemoAppState extends State<ExplicitAnimationDemoApp>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  late AnimationDirection animationDirection;
  late AnimationPlayState animationPlayState;

  double minSize = 0;
  double maxSize = 300;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    animationDirection = AnimationDirection.forward;
    animationPlayState = AnimationPlayState.paused;
    animation =
        Tween<double>(begin: minSize, end: maxSize).animate(controller)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              if (animationPlayState == AnimationPlayState.playing &&
                  animationDirection == AnimationDirection.forward) {
                controller.reset();
                controller.forward();
              }
            } else if (status == AnimationStatus.dismissed) {
              if (animationPlayState == AnimationPlayState.playing &&
                  animationDirection == AnimationDirection.reverse) {
                controller.value = 1.0;
                controller.reverse();
              }
            }
          })
          ..addStatusListener(
            (status) => print(
              'status: $status, animationPlayState: $animationPlayState, animationDirection: $animationDirection',
            ),
          );
  }

  void _startAnimation() {
    if (animationDirection == AnimationDirection.forward) {
      controller.forward();
    } else {
      // animationDirection == AnimationDirection.reverse
      if (controller.status == AnimationStatus.dismissed) {
        controller.value = 1.0;
      }
      controller.reverse();
    }
    animationPlayState = AnimationPlayState.playing;
  }

  void _pauseAnimation() {
    controller.stop();
    animationPlayState = AnimationPlayState.paused;
  }

  void _reverseAnimation() {
    if (animationDirection == AnimationDirection.forward) {
      animationDirection = AnimationDirection.reverse;
      if (animationPlayState == AnimationPlayState.playing) {
        controller.reverse();
      }
    } else {
      // animationDirection == AnimationDirection.reverse
      animationDirection = AnimationDirection.forward;
      if (animationPlayState == AnimationPlayState.playing) {
        controller.forward();
      }
    }
  }

  void _resetAnimation() {
    animationDirection = AnimationDirection.forward;
    animationPlayState = AnimationPlayState.paused;
    controller.reset();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      title: 'Explicit Animation Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Explicit Animation Demo'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: animation.value,
            width: animation.value,
            // child: const FlutterLogo(),
            child: Image.asset(
              'assets/images/capybara.jpg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: _startAnimation,
                    child: const Icon(Icons.play_arrow),
                  ),
                  const SizedBox(height: 8),
                  Text("Play", textAlign: TextAlign.center),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: _pauseAnimation,
                    child: const Icon(Icons.pause),
                  ),
                  const SizedBox(height: 8),
                  Text("Pause", textAlign: TextAlign.center),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: _reverseAnimation,
                    child: const Icon(Icons.sync),
                  ),
                  const SizedBox(height: 8),
                  Text("Reverse\nDirection", textAlign: TextAlign.center),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: _resetAnimation,
                    child: const Icon(Icons.replay),
                  ),
                  const SizedBox(height: 8),
                  Text("Reset\nAll", textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
