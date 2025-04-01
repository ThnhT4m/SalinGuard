// --- File: lib/widgets/details_card.dart --- // Giả sử bạn đặt nó ở đây
import 'package:flutter/material.dart';
import 'package:sagu/util/responsive.dart';
import 'package:sagu/widgets/about_product.dart';
import 'package:sagu/widgets/activity_details_card.dart'; // Sửa 'sagu' thành tên package/thư mục đúng của bạn nếu cần
// Import file responsive bạn vừa tạo/sửa đổi

class DetailsCard extends StatelessWidget {
  // Không cần tham số isMobile trong constructor nữa
  const DetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Gọi phương thức static từ file responsive.dart để xác định layout

    // Sử dụng giá trị boolean vừa lấy được để quyết định layout
    if (Responsive.isMobile(context)) {
      // --- Layout cho Mobile ---
      // Dùng Column, Card ở dưới
      return const Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Để Card giãn hết chiều rộng
        children: [
          // Bạn có thể thêm khoảng trống ở đây nếu muốn thay thế cho SizedBox ngang
          // SizedBox(height: 16.0),
          ActivityDetailsCard(),
        ],
      );
    } else {
      // --- Layout cho màn hình lớn hơn (Tablet/Desktop) ---
      // Dùng Row như code gốc của bạn
      return const Row(
        children: [
          Expanded(
            flex: 2,
            child: AboutProduct(), // Khoảng trống hoặc nội dung bên trái
          ),
          Expanded(
            flex: 6,
            child: ActivityDetailsCard(), // Card chính
          ),
        ],
      );
    }
  }
}
