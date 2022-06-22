import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DerivBottomSheet<T> extends StatelessWidget {
  const DerivBottomSheet({
    super.key,
    required this.child,
    this.padding,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;

  static Future<K?> show<K>(
    BuildContext context, {
    required Widget child,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    bool? isDismissible,
  }) =>
      showCupertinoModalBottomSheet(
        context: context,
        backgroundColor: backgroundColor,
        shadow: const BoxShadow(color: Colors.transparent),
        isDismissible: isDismissible,
        enableDrag: isDismissible ?? true,
        barrierColor: Colors.black.withOpacity(.4),
        builder: (context) {
          return DerivBottomSheet<K>(
            child: child,
            padding: padding,
          );
        },
      );

  static Future<C?> showClose<C>(
    BuildContext context, {
    required Widget child,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    bool? isDismissible,
    void Function()? onClose,
  }) {
    return show<C>(
      context,
      padding: padding,
      backgroundColor: backgroundColor ?? Colors.transparent,
      isDismissible: isDismissible,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.all(20).add(
            const EdgeInsets.only(bottom: 9),
          ),
      child: Material(
        color: Colors.black.withOpacity(0.00),
        child: child,
      ),
    );
  }
}

class DerivWhiteCard extends StatelessWidget {
  const DerivWhiteCard({
    super.key,
    this.child,
    this.padding,
  });

  final Widget? child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 30),
            child: child,
          ),
        ),
      ),
    );
  }
}
