import 'package:fl_chart/fl_chart.dart';

class LineData {
  final List<FlSpot> ecSpots = [];
  final List<FlSpot> tempSpots = [];
  final List<FlSpot> phSpots = [];

  void addData({
    required double ec,
    required double temp,
    required double ph,
    required double time,
  }) {
    ecSpots.add(FlSpot(time, ec));
    tempSpots.add(FlSpot(time, temp));
    phSpots.add(FlSpot(time, ph));

    if (ecSpots.length > 30) ecSpots.removeAt(0);
    if (tempSpots.length > 30) tempSpots.removeAt(0);
    if (phSpots.length > 30) phSpots.removeAt(0);
  }
}
