import 'package:flutter/material.dart';
import 'package:sagu/widgets/custom_card_wiget.dart';
import 'package:sagu/widgets/line_chart_widget.dart';

class LineChartCard extends StatelessWidget {
  const LineChartCard({super.key});
  @override
  Widget build(BuildContext context) {
    // final data = LineData(); // Lấy dữ liệu chart của bạn
    return CustomCard(
      // Đảm bảo CustomCard này không có width cố định
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            // Đã có const
            "Steps Overview",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          AspectRatio(
            // <-- Widget quan trọng giúp duy trì tỷ lệ và co giãn
            aspectRatio: 23 / 7,
            // Tỷ lệ chiều rộng / chiều cao
            // Khi chiều rộng của CustomCard thay đổi, AspectRatio sẽ tính toán
            // chiều cao tương ứng để LineChart vừa vặn.
            child:
                LineChartWidget(), // Tách LineChart ra widget riêng để dễ quản lý (tùy chọn)
            // Hoặc giữ nguyên LineChart ở đây nếu bạn thích:
          ),
        ],
      ),
    );
  }
}
