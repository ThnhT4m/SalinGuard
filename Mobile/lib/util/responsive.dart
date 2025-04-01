import 'package:flutter/widgets.dart'; // Thay Cupertino bằng Widgets hoặc Material

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  // SỬA LỖI LOGIC Ở ĐÂY: Phải là >= 600 và < 1100
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 600; // Sửa '< 600' thành '>= 600'

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >=
      1100; // Sửa '>' thành '>=' để bao gồm cả 1100
}
