import 'package:flutter/material.dart';
import 'package:sagu/const/constant.dart'; // Đảm bảo import constant nếu sử dụng defaultPadding hoặc màu sắc
import 'package:sagu/util/responsive.dart'; // Import Responsive
import 'package:sagu/widgets/dashboard_widget.dart';
import 'package:sagu/widgets/header_widget.dart'; // Import HeaderWidget
import 'package:sagu/widgets/notification_widget.dart';
import 'package:sagu/widgets/side_menu_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    // Không cần biến isMobile nữa vì !isDesktop bao gồm cả Mobile và Tablet

    return Scaffold(
      // Drawer hiển thị trên Mobile & Tablet
      drawer:
          !isDesktop // <-- SỬA Ở ĐÂY
              ? const SizedBox(width: 250, child: SideMenuWidget())
              : null,

      // EndDrawer hiển thị trên Mobile & Tablet
      endDrawer:
          !isDesktop // <-- SỬA Ở ĐÂY
              ? SizedBox(
                // Có thể điều chỉnh độ rộng cho Tablet nếu muốn, ví dụ 80%
                width:
                    Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.6,
                child: const NotificationWidget(),
              )
              : null,

      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SideMenuWidget chỉ hiển thị trên Desktop
            if (isDesktop) const Expanded(flex: 1, child: SideMenuWidget()),

            // Nội dung chính (Header cố định + Nội dung cuộn)
            Expanded(
              flex: 5, // Điều chỉnh flex nếu cần
              child: Stack(
                children: [
                  // 1. Scrollable Content (Dashboard)
                  // Thêm Padding trên cùng bằng chiều cao Header + khoảng cách mong muốn
                  Positioned.fill(
                    top: defaultPadding, // Chiều cao HeaderWidget + padding
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                      ), // Padding ngang
                      child: Column(
                        children: const [
                          SizedBox(
                            height: defaultPadding,
                          ), // Khoảng cách đầu tiên
                          DashboardWidget(), // Nội dung chính
                          SizedBox(
                            height: defaultPadding,
                          ), // Khoảng cách cuối cùng (nếu cần)
                          // ... Các widget có thể cuộn khác
                        ],
                      ),
                    ),
                  ),

                  // 2. Fixed Header
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80, // Chiều cao cố định cho header
                      color:
                          Theme.of(
                            context,
                          ).scaffoldBackgroundColor, // Màu nền để che nội dung bên dưới
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding,
                        ), // Padding cho HeaderWidget
                        child: HeaderWidget(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // NotificationWidget chỉ hiển thị trên Desktop (có thể thêm nếu cần)
          ],
        ),
      ),
    );
  }
}
