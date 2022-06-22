import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  double screenHeight([double percent = 1]) =>
      MediaQuery.of(this).size.height * percent;

  double screenWidth([double percent = 1]) =>
      MediaQuery.of(this).size.width * percent;
}

extension StringExtensions on String {
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      length > 1 ? split(' ').map((str) => str.toUpperCase()).join(' ') : this;

  String get svg => 'assets/images/svg/$this.svg';
  String get png => 'assets/images/png/$this.png';
  String get jpg => 'assets/images/png/$this.jpg';
}

extension WidgetUtilitiesX on Widget {
  /// Animated show/hide based on a test, with overrideable duration and curve.
  ///
  /// Applies [IgnorePointer] when hidden.
  Widget showIf(
    bool test, {
    Duration duration = const Duration(milliseconds: 350),
    Curve curve = Curves.easeInOut,
  }) =>
      AnimatedOpacity(
        opacity: test ? 1.0 : 0.0,
        duration: duration,
        curve: curve,
        child: IgnorePointer(
          ignoring: test == false,
          child: this,
        ),
      );

  /// Scale this widget by `scale` pixels.
  Widget scale([
    double scale = 0.0,
  ]) =>
      Transform.scale(
        scale: scale,
        child: this,
      );

  /// Transform this widget `x` or `y` pixels.
  Widget nudge({
    double x = 0.0,
    double y = 0.0,
  }) =>
      Transform.translate(
        offset: Offset(x, y),
        child: this,
      );

  /// Rotate this widget by `x` `turns`
  Widget rotate({
    int turns = 0,
  }) =>
      RotatedBox(
        quarterTurns: turns,
        child: this,
      );

  /// Wrap this widget in a [SliverToBoxAdapter]
  ///
  /// If you need access to `key`, do not use this extension method.
  Widget get asSliver => SliverToBoxAdapter(child: this);
}
