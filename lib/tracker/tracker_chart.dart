import 'package:deriv_repository/deriv_repository.dart';
import 'package:deriv_tracker/tracker/cubit/deriv_tracker_cubit.dart';
import 'package:deriv_tracker/utils/extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TrackerChart extends StatefulWidget {
  final DerivTrackerState state;
  const TrackerChart(this.state, {Key? key}) : super(key: key);

  @override
  TrackerChartState createState() => TrackerChartState();
}

class TrackerChartState extends State<TrackerChart> {
  var ticks = <Tick>[];

  @override
  Widget build(BuildContext context) {
    final tick = widget.state.binaryTickerModel.tick;
    if (tick.id.isNotEmpty) {
      ticks.insert(0, tick);
    }
    ticks = ticks.take(50).toList();
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.20,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24,
              bottom: 12,
            ),
            child: LineChart(mainData),
          ),
        ).nudge(x: -30),
      ],
    );
  }

  LineChartData get mainData {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (_, __) => const Offstage(),
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (_, __) => const Offstage(),
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: ticks.reversed
              .map((it) => FlSpot(it.epoch.toDouble(), it.quote))
              .toList(),
          isCurved: true,
          color: Colors.black,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black26,
                ],
              )),
        ),
      ],
    );
  }
}
