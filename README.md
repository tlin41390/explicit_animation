# CSEN 268 - Explicit Animations

In Flutter, **explicit animations** give you full control over the animation process. These are useful when you want precise timing, coordination, or interactivity that **implicit animations** can’t provide.


## Animation Controller

An object that **controls the animation**—you can start, stop, reverse, or repeat the animation. It requires a `vsync` (usually provided by `SingleTickerProviderStateMixin`).

```
controller = AnimationController(
	duration: const  Duration(seconds: 2),
	vsync: this,
);
```

Common fields and methods from the AnimationController are:

-   `value`: Internal value of the animation.
-   `forward()`: Start the animation and progresses the invernal value from 0.0 to 1.0.
-   `reverse()`: Reverses the animation and moves the internal value from 1.0 to 0.0.
-   `stop()`: Stops the animations at the current internal value.
-   `addListener()`: Registers a function that will be invoked when the controller value changes.

## Tween 

By default, an `AnimationController` goes from 0.0 to 1.0. A `Tween` maps that range to custom values—for example, pixel positions, opacity, or color.
```
animation = Tween<double>(begin: 0, end: 300).animate(controller)
	..addListener(() {
	setState(() {});
});
```

You can use `Tween<T>` for:
-   `double` values (e.g., size, offset)
-   `ColorTween`
-   `AlignmentTween`
-   and more

## SingleTickerProviderMixIn

The `AnimationController` requires a `TickerProvider` to produce animation "ticks" (frames). This is commonly provided by the widget’s state class using `SingleTickerProviderStateMixin`.

```
class  _LogoAppState  extends  State<LogoApp> with  SingleTickerProviderStateMixin {
	late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

Use `TickerProviderStateMixin` if you need multiple animations (more than one `AnimationController`).

## Animation Controls 
These functions control the animation at runtime, such as starting, pausing, restarting, or reversing the direction. You can wire them to buttons or other user interactions.

```
void  _startAnimation() {
	controller.forward();
}

void  _pauseAnimation() {
	controller.stop();
}

void  _restartAnimation() {
	controller.reset();
}

void  _reverseAnimation() {
	if (controller.status == AnimationStatus.forward ||
	controller.status == AnimationStatus.completed) {
		controller.reverse();
	} else {
		controller.forward();
	}
}
```

-   `forward()`: Starts or resumes the animation forward.
-   `stop()`: Pauses the animation at its current position.
-   `reset()`: Resets the controller value to 0.0.
-   `reverse()`: Reverses the animation if currently running or completed; otherwise, it plays forward.

## Dispose
Dispose your AnimationController using the dispose() method to prevent memory leaks:
```
@override
 void dispose() {
   controller.dispose();
   super.dispose();
 }
```
