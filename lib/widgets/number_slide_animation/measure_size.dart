import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Measures a widget's size after build and returns it in the provided `onChange` callback.
/// Credits: https://stackoverflow.com/a/60868972
class MeasureSize extends StatefulWidget {
  const MeasureSize({
    required this.onChange,
    required this.child,
    super.key,
  });

  final Widget child;
  final Function(Size) onChange;

  @override
  MeasureSizeState createState() => MeasureSizeState();
}

class MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  final widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(_) {
    void updateSize() {
      final context = widgetKey.currentContext;
      if (context == null) return;

      final newSize = context.size;
      if (oldSize == newSize) return;

      oldSize = newSize;
      widget.onChange(newSize ?? Size.zero);
    }

    try {
      updateSize();
    } catch (e) {
      /// If there is an error, it means that the layout has not been drawn yet,
      /// It will be called again once the layout has been build
    }
  }
}
