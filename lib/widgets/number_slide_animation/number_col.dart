import 'package:deriv_tracker/widgets/number_slide_animation/last_change.dart';
import 'package:deriv_tracker/widgets/number_slide_animation/measure_size.dart';
import 'package:flutter/material.dart';

/// Each [NumberCol] has the numbers 0-9 stacked inside of a [SingleChildScrollView]
/// via a [ScrollController] the position will be animated to the requested number
class NumberCol extends StatefulWidget {
  const NumberCol({
    super.key,
    required this.number,
    required this.textStyle,
    required this.numberDuration,
    required this.numberCurve,
    required this.latestChange,
    required this.increaseColor,
    required this.decreaseColor,
    required this.colorCurve,
    required this.colorDuration,
  });

  /// The numeric value that should be displayed, formatted as a string.
  /// This could be a currency like `$32.00` or just a number `5.00`.
  final int number;

  /// The TextStyle to use.
  final TextStyle textStyle;

  /// Duration of number change animation.
  final Duration numberDuration;

  /// Curve for number change animation.
  final Curve numberCurve;

  /// Whether the value has increased, decreased, or is no change
  final NumberChange latestChange;

  /// Duration of color change animation.
  final Duration colorDuration;

  /// Curve for color change animation.
  final Curve colorCurve;

  /// Colors for number increase/decrease
  final Color increaseColor;
  final Color decreaseColor;

  @override
  NumberColState createState() => NumberColState();
}

class NumberColState extends State<NumberCol>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  late final AnimationController colorAnimationController;
  late ColorTween colorTween;
  late Animation colorAnimation;

  var _elementSize = 0.0;
  var textColor = Colors.transparent;

  /// After layout we measure the width of the text character
  /// to enforce that width on our scrollview.
  var textWidth = 0.0;

  @override
  void initState() {
    super.initState();

    colorAnimationController = AnimationController(
      vsync: this,
      duration: widget.colorDuration,
    );

    colorTween = ColorTween(
      begin: widget.textStyle.color,
      end: widget.latestChange == NumberChange.increase
          ? widget.increaseColor
          : widget.latestChange == NumberChange.decrease
              ? widget.decreaseColor
              : widget.textStyle.color,
    );

    colorAnimation = colorTween.animate(CurvedAnimation(
      parent: colorAnimationController,
      curve: widget.colorCurve,
    ))
      ..addListener(() {
        setState(() {});
      });

    colorAnimationController.forward().whenComplete(() {
      colorAnimationController.reverse();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _elementSize = _scrollController.position.maxScrollExtent / 10;
      setState(() {});

      /// For the first paint, just immediately jump to the spot instead of animating to it
      _scrollController.jumpTo(
        _elementSize * widget.number,
      );
    });
  }

  @override
  void dispose() {
    colorAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    _scrollController.animateTo(
      _elementSize * widget.number,
      duration: widget.numberDuration,
      curve: widget.numberCurve,
    );

    if (widget.number != oldWidget.number &&
        widget.latestChange != NumberChange.noChange) {
      colorTween = ColorTween(
        begin: widget.textStyle.color,
        end: widget.latestChange == NumberChange.increase
            ? widget.increaseColor
            : widget.latestChange == NumberChange.decrease
                ? widget.decreaseColor
                : widget.textStyle.color,
      );

      colorAnimation = colorTween.animate(CurvedAnimation(
          parent: colorAnimationController, curve: widget.numberCurve))
        ..addListener(() {
          setState(() {});
        });

      colorAnimationController.forward().whenComplete(() {
        colorAnimationController.reverse();
      });
    }
  }

  Widget getTextWidget(int position) => Text(
        position.toString(),
        style: widget.textStyle.copyWith(
          color: colorAnimation.value,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Invisible text widget to measure size and adjust
        /// our constraints for the correct width.
        Opacity(
          opacity: 0,
          child: MeasureSize(
            onChange: (size) {
              setState(() {
                textWidth = size.width;
              });
            },
            child: getTextWidget(widget.number),
          ),
        ),

        IgnorePointer(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: _elementSize,
              maxWidth: textWidth,
            ),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: List.generate(10, (position) {
                  return getTextWidget(position);
                }),
              ),
            ),
          ),
        )
      ],
    );
  }
}
