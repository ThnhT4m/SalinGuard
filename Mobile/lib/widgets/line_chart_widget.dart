import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sagu/data/line_chart_data.dart';
import 'package:sagu/util/responsive.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  late final LineData data;
  double _timeIndex = 0;

  @override
  void initState() {
    super.initState();
    data = LineData();

    FirebaseDatabase.instance.ref().onValue.listen((event) {
      final snapshot = event.snapshot.value;
      if (snapshot is Map) {
        final double ec = double.tryParse(snapshot['EC'].toString()) ?? 0;
        final double temp = double.tryParse(snapshot['Temp'].toString()) ?? 0;
        final double ph = double.tryParse(snapshot['pH'].toString()) ?? 0;

        setState(() {
          data.addData(ec: ec, temp: temp, ph: ph, time: _timeIndex);
          _timeIndex += 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          clipData: FlClipData.all(), // 👈 Giải quyết lỗi "lồi" ra ngoài
          minX: _timeIndex > 30 ? _timeIndex - 30 : 0,
          maxX: _timeIndex,
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: data.ecSpots,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
            LineChartBarData(
              spots: data.tempSpots,
              isCurved: true,
              color: Colors.orange,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
            LineChartBarData(
              spots: data.phSpots,
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: isMobile ? 20 : 10,
                reservedSize: isMobile ? 28 : 40,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        fontSize: isMobile ? 9 : 11,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: isMobile ? 10 : 5,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        fontSize: isMobile ? 9 : 11,
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          gridData: FlGridData(show: true),
        ),
      ),
    );
  }
}
