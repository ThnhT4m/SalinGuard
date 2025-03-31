import 'package:flutter/material.dart';
import 'package:sagu/util/responsive.dart'; // Import the Responsive utility
import 'package:sagu/widgets/about_product.dart'; // Import the AboutProduct widget
import 'package:sagu/widgets/details_card.dart';
import 'package:sagu/widgets/line_chart_card.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 35),
            // Conditionally render AboutProduct based on screen size
            if (Responsive.isMobile(context)) const AboutProduct(),
            if (Responsive.isMobile(context))
              const SizedBox(
                height: 20,
              ), // Add spacing after AboutProduct on mobile
            const DetailsCard(),
            const SizedBox(height: 20),
            const LineChartCard(),
          ],
        ),
      ),
    );
  }
}
