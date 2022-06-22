import 'package:flutter/material.dart';

/// Displays a number and when the inputted value changes to a new one, animates
/// the value change to its new value.
class NumberChangeWidget<T> extends StatefulWidget {
  const NumberChangeWidget({
    required this.builder,
    required this.value,
    super.key,
  });
  final Widget Function(BuildContext context, T newValue) builder;
  final T value;

  @override
  NumberChangeWidgetState<T> createState() => NumberChangeWidgetState<T>();
}

class NumberChangeWidgetState<T> extends State<NumberChangeWidget<T>>
    with SingleTickerProviderStateMixin {
  late Animation<T> animation;
  late AnimationController animationController;

  @override
  void didUpdateWidget(NumberChangeWidget oldWidget) {
    // sc(context).logger.d('didUpdateWidget | val: ${widget.value}');

    animation = Tween<T>(begin: oldWidget.value, end: widget.value).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {});
      });
    animationController.reset();
    animationController.forward();
    super.didUpdateWidget(oldWidget as NumberChangeWidget<T>);
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<T>(begin: widget.value, end: widget.value).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.fastLinearToSlowEaseIn));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) {
        return widget.builder(context, animation.value);
      },
    );
  }
}
