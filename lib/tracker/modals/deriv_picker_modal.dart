import 'package:deriv_tracker/tracker/widgets/deriv_drop_down.dart';
import 'package:deriv_tracker/utils/extension.dart';
import 'package:deriv_tracker/widgets/bottom_sheet.dart';
import 'package:deriv_tracker/widgets/touchable_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DerivPickerModal<T> extends StatelessWidget {
  const DerivPickerModal({
    super.key,
    this.itemList = const [],
    this.title,
    this.itemBuilder,
  });

  final List<T> itemList;
  final String? title;
  final DerivDropdownButtonItemBuilder<T>? itemBuilder;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    List<T> itemList = const [],
    DerivDropdownButtonItemBuilder<T>? itemBuilder,
  }) {
    return DerivBottomSheet.showClose<T>(
      context,
      padding: EdgeInsets.zero,
      child: DerivWhiteCard(
        child: DerivPickerModal(
          title: title,
          itemList: itemList,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenHeight(.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 24,
            ),
            child: Text(
              title ?? '',
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Flexible(
            child: ListView(
              children: [
                for (final item in itemList)
                  TouchableOpacity(
                    onTap: () => Navigator.pop(context, item),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          const Divider(),
                          const Gap(20),
                          Row(
                            children: [
                              itemBuilder != null
                                  ? itemBuilder!(item)
                                  : Text(
                                      '$item',
                                      style: GoogleFonts.sora(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                              const Spacer(),
                              SvgPicture.asset('arrow_right'.svg),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
