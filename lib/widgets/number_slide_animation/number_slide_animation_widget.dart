import 'package:deriv_tracker/widgets/number_slide_animation/last_change.dart';
import 'package:flutter/material.dart';

import 'src/../number_col.dart';

/// Animates a numeric value using a number digit slide effect, changing
/// it to green/red as it changes.
///
/// Note: you should avoid changing the font size regularly in this widget
/// because it will not do well. The reason is because every font size change
/// will require re-scrolling to the right position and it becomes very expensive
/// computationally, and will not look smooth. You should wrap this widget in a
/// `Transform.translate` widget to achieve the effect of changing the font size
/// frequently.
class NumberSlideAnimation extends StatefulWidget {
  const NumberSlideAnimation({
    required this.number,
    required this.parseNumber,
    required this.textStyle,
    required this.increaseColor,
    required this.decreaseColor,
    this.numberDuration = const Duration(milliseconds: 500),
    this.numberCurve = Curves.easeIn,
    this.colorCurve = Curves.easeOut,
    this.colorDuration = const Duration(milliseconds: 500),
    this.ignoreColorChanges = false,
  });

  /// Function used to parse the number into a double. This is
  /// used to compare if the number increases or decreases on
  /// each change. Useful if you are displaying a currency value
  /// and need a special funciton to parse that currency into its
  /// numeric representation.
  final double Function(String) parseNumber;

  /// The numeric value that should be displayed, formatted as a string.
  /// This could be a currency like `$32.00` or just a number `5.00`.
  final String number;

  /// The TextStyle to use.
  final TextStyle textStyle;

  /// Duration of number change animation.
  final Duration numberDuration;

  /// Curve for number change animation.
  final Curve numberCurve;

  /// Duration of color change animation.
  final Duration colorDuration;

  /// Curve for color change animation.
  final Curve colorCurve;

  /// Colors for number increase/decrease
  final Color increaseColor;
  final Color decreaseColor;

  /// Ignore number change coloring
  final bool ignoreColorChanges;

  @override
  NumberSlideAnimationState createState() => NumberSlideAnimationState();
}

class NumberSlideAnimationState extends State<NumberSlideAnimation> {
  var latestChange = NumberChange.noChange;

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.ignoreColorChanges != oldWidget.ignoreColorChanges) {
      /// If we are ignoring color changes, set the latest change to noChange. If we
      /// don't do this then if we start dragging on the portfolio chart while the
      /// number changes and flashes a color, the color will persist for all number
      /// changes while tapped down on the chart.
      setState(() => latestChange = NumberChange.noChange);
    }

    /// Only set the increase/decrease color if we're not ignoring changes
    if (!widget.ignoreColorChanges) {
      final parsedNewValue = widget.parseNumber(widget.number);
      final parsedOldValue = oldWidget.parseNumber(oldWidget.number);

      setState(
        () => latestChange = parsedNewValue > parsedOldValue
            ? NumberChange.increase
            : parsedNewValue < parsedOldValue
                ? NumberChange.decrease
                : NumberChange.noChange,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...widget.number.characters.map((e) {
          final isDigit = RegExp(r'\d').hasMatch(e);

          /// If it's not a digit then just return a text widget
          /// to dispaly that character.
          if (!isDigit) {
            return Text(
              e,
              style: widget.textStyle,
            );
          }

          return NumberCol(
            colorCurve: widget.colorCurve,
            colorDuration: widget.colorDuration,
            number: int.parse(e),
            textStyle: widget.textStyle,
            numberDuration: widget.numberDuration,
            numberCurve: widget.numberCurve,
            increaseColor: widget.increaseColor,
            decreaseColor: widget.decreaseColor,
            latestChange: latestChange,
          );
        }).toList(),
      ],
    );
  }
}
