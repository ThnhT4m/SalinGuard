import 'package:flutter/material.dart';
import 'package:sagu/widgets/custom_card_wiget.dart';
import 'package:sagu/widgets/line_chart_widget.dart';
import 'package:sagu/util/responsive.dart'; // Import responsive logic

class LineChartCard extends StatelessWidget {
  const LineChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final chartHeight =
        isMobile
            ? 200.0
            : isTablet
            ? 280.0
            : 360.0; // Desktop

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Steps Overview",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: chartHeight,
            width: double.infinity,
            child: const LineChartWidget(),
          ),
        ],
      ),
    );
  }
}
