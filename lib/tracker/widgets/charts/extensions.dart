import 'dart:math' as math;

import 'package:flutter/rendering.dart';

extension DoubleExtensions on double {
  double discretize(int divisions) => (this * divisions).round() / divisions;

  double lerp(double min, double max) {
    assert(this >= 0.0, '');
    assert(this <= 1.0, '');
    return this * (max - min) + min;
  }

  double unlerp(double min, double max) {
    assert(this <= max, '');
    assert(this >= min, '');
    return max > min ? (this - min) / (max - min) : 0.0;
  }
}

const fullAngle = 360.0;
const fullAngleInRadians = math.pi * 2.0;

extension NumExtensions<T extends num> on T {
  double get degrees => (this * 180.0) / math.pi;

  double get radians => (this * math.pi) / 180.0;

  T normalize(T max) => (this % max + max) % max as T;

  double get normalizeAngle => normalize(fullAngleInRadians as T).toDouble();

  double subtractAngle(T diff) => (this - diff).normalizeAngle;

  double addAngle(T diff) => (this + diff).normalizeAngle;

  double shiftAngle(T shift) =>
      toDouble() +
      ((-this - shift) / fullAngleInRadians).ceil() * fullAngleInRadians;

  bool between(double min, double max) => this <= max && this >= min;
}

extension SizeExtensions on Size {
  double get radius => shortestSide / 2;

  Size copyWith({double? width, double? height}) =>
      Size(width ?? this.width, height ?? this.height);
}

extension RectExtensions on Rect {
  double get radius => size.radius;

  Rect shrink({
    double top = 0.0,
    double left = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Rect.fromLTRB(
        this.left + left,
        this.top + top,
        this.right - right,
        this.bottom - bottom,
      );
}

extension OffsetExtensions on Offset {
  Offset shift(double delta) => translate(delta, delta);

  Offset translateAlong(double angleInRadians, double magnitude) =>
      this + Offset.fromDirection(angleInRadians, magnitude);
}

extension CanvasExtensions on Canvas {
  static const TextStyle _defaultTextStyle = TextStyle(
    fontSize: 14,
    color: Color(0xFF333333),
    fontWeight: FontWeight.normal,
  );

  TextLayoutResult layoutText(
    String text, {
    TextStyle style = _defaultTextStyle,
    double maxWidth = double.infinity,
  }) =>
      TextLayoutResult(
        canvas: this,
        painter: TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        )
          ..text = TextSpan(text: text, style: style)
          ..layout(maxWidth: maxWidth),
      );

  Rect drawText(
    String text, {
    required Offset center,
    TextStyle style = _defaultTextStyle,
    double maxWidth = double.infinity,
  }) =>
      layoutText(text, style: style, maxWidth: maxWidth).paint(center);
}

double toAngle(Offset position, Offset center) => (position - center).direction;

Offset toPolar(Offset center, double radians, double radius) =>
    center + Offset.fromDirection(radians, radius);

double normalizeAngle(double angle) {
  final totalAngle = 360.radians;
  return (angle % totalAngle + totalAngle) % totalAngle;
}

double random(double min, double max) =>
    math.max(math.min(max, math.Random().nextDouble() * max), min);

class Pair<A, B> {
  const Pair(this.a, this.b);

  final A a;
  final B b;
}

class Triple<A, B, C> {
  const Triple(this.a, this.b, this.c);

  final A a;
  final B b;
  final C c;
}

class Range<T> {
  const Range(this.start, this.end);

  final T start;
  final T end;
}

class TextLayoutResult {
  const TextLayoutResult({required Canvas canvas, required TextPainter painter})
      : _canvas = canvas,
        _painter = painter;

  final Canvas _canvas;
  final TextPainter _painter;

  Size get size => _painter.size;

  Rect paint(Offset center) {
    final Rect bounds =
        Rect.fromCenter(center: center, width: size.width, height: size.height);
    _painter.paint(_canvas, bounds.topLeft);
    return bounds;
  }
}

mixin RenderBoxDebugBounds on RenderBox {
  Set<Rect> debugBounds = {};
  Set<Path> debugPaths = {};

  @override
  void debugPaint(PaintingContext context, Offset offset) {
    assert(
      () {
        super.debugPaint(context, offset);

        if (debugPaintSizeEnabled) {
          for (final bounds in debugBounds) {
            context.canvas.drawRect(
              bounds,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = const Color(0xFF00FFFF),
            );
          }
          for (final path in debugPaths) {
            context.canvas.drawPath(
              path,
              Paint()
                ..style = PaintingStyle.stroke
                ..color = const Color(0xFF00FFFF),
            );
          }
        }

        return true;
      }(),
      '',
    );
    debugBounds.clear();
    debugPaths.clear();
  }
}
