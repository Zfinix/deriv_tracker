import 'package:deriv_tracker/tracker/modals/deriv_picker_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:deriv_tracker/utils/extension.dart';
import 'package:deriv_tracker/widgets/touchable_opacity.dart';

/// Dropdown widget item builder
typedef DerivDropdownButtonItemBuilder<T> = Widget Function(T value);

/// Dropdown button that allows item selection from a list
class DerivDropdownButton<T> extends StatefulWidget {
  final String? title;
  final T selectedItem;
  final List<T> itemList;
  final ValueChanged<T> onSelectValue;
  final DerivDropdownButtonItemBuilder<T>? itemBuilder;
  const DerivDropdownButton({
    super.key,
    this.title,
    this.itemBuilder,
    required this.onSelectValue,
    required this.selectedItem,
    this.itemList = const [],
  });

  @override
  State<DerivDropdownButton<T>> createState() => _DerivDropdownButtonState<T>();
}

class _DerivDropdownButtonState<T> extends State<DerivDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? '',
          style: GoogleFonts.sora(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const Gap(10),
        TouchableOpacity(
          onTap: () async {
            if (widget.itemList.isEmpty) {
              return;
            }

            final val = await DerivPickerModal.show<T>(
              context,
              title: widget.title,
              itemBuilder: widget.itemBuilder,
              itemList: widget.itemList,
            );

            if (val != null) {
              widget.onSelectValue(val);
            }
          },
          child: Container(
            height: 68,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 26,
                  color: Colors.black.withOpacity(0.04),
                )
              ],
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                widget.itemBuilder != null
                    ? widget.itemBuilder!(widget.selectedItem)
                    : Text(
                        '${widget.selectedItem}',
                        style: GoogleFonts.sora(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                const Spacer(),
                SvgPicture.asset('arrow'.svg),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
