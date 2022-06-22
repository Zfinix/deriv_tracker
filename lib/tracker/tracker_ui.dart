import 'package:deriv_repository/deriv_repository.dart';
import 'package:deriv_tracker/tracker/tracker_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:deriv_tracker/tracker/tracker.dart';
import 'package:deriv_tracker/widgets/number_slide_animation/number_slide_animation_widget.dart';

class DerivTrackerUI extends StatelessWidget {
  const DerivTrackerUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<DerivTrackerCubit, DerivTrackerState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case DerivTrackerStatus.loading:
            return Stack(
              children: [
                AbsorbPointer(child: DerivTrackerPopulated(state)),
                Positioned.fill(
                  child: Container(
                    color: Colors.white70,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),
              ],
            );
          case DerivTrackerStatus.initial:
          case DerivTrackerStatus.success:
            return DerivTrackerPopulated(state);
          case DerivTrackerStatus.failure:
          default:
            return DerivTrackerError();
        }
      },
    ));
  }
}

class DerivTrackerPopulated extends StatelessWidget {
  final DerivTrackerState state;
  const DerivTrackerPopulated(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final tick = state.binaryTickerModel.tick;
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Text(
              state.selectedSymbol?.displayName ?? '#/#',
              style: GoogleFonts.sora(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Gap(20),
            Container(
              height: 40,
              child: NumberSlideAnimation(
                number: '${tick.quote}',
                parseNumber: (source) => double.parse(source),
                increaseColor: Colors.red,
                decreaseColor: Colors.green,
                textStyle: GoogleFonts.sora(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Ask: ',
                    children: [
                      TextSpan(
                        text: '${tick.ask}',
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: GoogleFonts.sora(),
                ),
                const Gap(70),
                Text.rich(
                  TextSpan(
                    text: 'Bid: ',
                    children: [
                      TextSpan(
                        text: '${tick.bid}',
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: GoogleFonts.sora(),
                ),
              ],
            ),
          ],
        ),
        const Gap(30),
        TrackerChart(state),
        const Gap(40),
        DerivDropdownButton(
          title: 'Market',
          onSelectValue: (val) {},
          selectedItem: 'Forex',
        ),
        const Gap(34),
        DerivDropdownButton<ActiveSymbol>(
          title: 'Symbol',
          onSelectValue: context.read<DerivTrackerCubit>().updateSelectedSymbol,
          itemList: state.activeSymbols,
          selectedItem: state.selectedSymbol ?? ActiveSymbol.empty,
          itemBuilder: (val) {
            return Text(
              val.displayName.isEmpty ? 'Select Symbol' : val.displayName,
              style: GoogleFonts.sora(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            );
          },
        ),
      ],
    );
  }
}

class DerivTrackerError extends StatelessWidget {
  const DerivTrackerError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Unable to Load Data'));
  }
}
