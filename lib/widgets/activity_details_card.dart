import 'package:flutter/material.dart';
// Giả sử các import này đúng với cấu trúc dự án của bạn
import 'package:sagu/data/index_details.dart';
import 'package:sagu/util/responsive.dart';
import 'package:sagu/widgets/custom_card_wiget.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Giả sử bạn khởi tạo IndexDetails như thế này
    // hoặc lấy nó từ Provider/Riverpod/GetX...
    final indexDetails = IndexDetails();

    return GridView.builder(
      itemCount: indexDetails.IndexData.length,
      shrinkWrap: true,
      physics:
          const ScrollPhysics(), // Bạn có thể bỏ dòng này nếu muốn GridView cuộn cùng với widget cha

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4, // Số cột
        crossAxisSpacing:
            Responsive.isMobile(context)
                ? 20
                : 20, // Khoảng cách ngang giữa các card
        mainAxisSpacing: 20.0, // Khoảng cách dọc giữa các card
        // === THÊM DÒNG NÀY ===
        childAspectRatio: 0.8, // Tỷ lệ Width/Height. > 1.0 = Rộng hơn cao.
        // Thay đổi giá trị này (ví dụ: 1.5, 1.8, 2.0) để điều chỉnh độ rộng.
        // Nếu muốn cao hơn rộng, dùng giá trị < 1.0 (ví dụ: 0.8)
        // =====================
      ),
      itemBuilder:
          (context, index) => CustomCard(
            // Giả sử CustomCard xử lý nền và bo góc
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Căn giữa text nếu card rộng ra
              children: [
                Padding(
                  // Điều chỉnh padding nếu cần cho phù hợp với kích thước mới
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 4,
                  ), // Giảm padding top một chút
                  child: Text(
                    indexDetails.IndexData[index].value,
                    style: const TextStyle(
                      fontSize: 18,
                      color:
                          Colors
                              .white, // Đảm bảo màu này phù hợp với nền của CustomCard
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center, // Căn giữa giá trị
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ), // Thêm padding ngang cho title
                  child: Text(
                    indexDetails.IndexData[index].title,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center, // Căn giữa tiêu đề
                    maxLines: 1, // Giới hạn 1 dòng nếu tiêu đề quá dài
                    overflow:
                        TextOverflow.ellipsis, // Hiển thị '...' nếu quá dài
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
