import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sagu/const/constant.dart';
import 'package:sagu/data/line_chart_data.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = LineData(); // Lấy dữ liệu (có thể truyền vào nếu cần)

    // Lấy kích thước hiện tại để có thể điều chỉnh chi tiết nếu muốn
    // final screenWidth = MediaQuery.of(context).size.width;
    // final bool isSmallScreen = screenWidth < 600; // Ví dụ breakpoint

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(handleBuiltInTouches: true),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                // Logic lấy title dưới (giữ nguyên hoặc điều chỉnh)
                return data.bottomTitle[value.toInt()] != null
                    ? Padding(
                      // Thêm Padding nhỏ để tránh bị cắt
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        data.bottomTitle[value.toInt()].toString(),
                        style: TextStyle(
                          fontSize: 10, // Có thể giảm cỡ chữ nếu màn hình nhỏ
                          color: Colors.grey[600], // Màu rõ hơn chút
                        ),
                      ),
                    )
                    : const SizedBox();
              },
              interval: 10, // Có thể tăng interval nếu màn hình nhỏ để đỡ rối
              // reservedSize: isSmallScreen ? 20 : 30, // Giảm không gian nếu màn hình nhỏ
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              getTitlesWidget: (double value, TitleMeta meta) {
                // Logic lấy title trái (giữ nguyên hoặc điều chỉnh)
                return data.leftTitle[value.toInt()] != null
                    ? Text(
                      data.leftTitle[value.toInt()].toString(),
                      style: TextStyle(
                        fontSize: 10, // Có thể giảm cỡ chữ
                        color: Colors.grey[600],
                      ),
                    )
                    : const SizedBox();
              },
              showTitles: true,
              interval: 10, // Có thể tăng interval nếu màn hình nhỏ
              reservedSize:
                  20, // Điều chỉnh không gian cần thiết cho số bên trái
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            color: selectionColor,
            barWidth: 2.0, // Có thể làm thanh mảnh hơn
            isCurved: true,
            belowBarData: BarAreaData(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  selectionColor.withOpacity(0.4), // Giảm độ mờ chút
                  Colors.transparent,
                ],
              ),
              show: true,
            ),
            dotData: FlDotData(show: false),
            spots: data.spots,
          ),
        ],
        minX: 0,
        maxX: 125, // Giữ nguyên hoặc điều chỉnh nếu cần
        maxY: 120,
        minY: -5,
      ),
    );
  }
}
