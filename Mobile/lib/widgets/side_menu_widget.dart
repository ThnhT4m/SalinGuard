import 'package:flutter/material.dart';
import 'package:sagu/const/constant.dart'; // Giả định chứa selectionColor
import 'package:sagu/data/side_menu_data.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int? selectedMainMenuIndex; // Index của menu chính được chọn
  int? selectedSubMenuIndex; // Index của submenu được chọn (nếu có)
  String? selectedTitle; // Title của item được chọn cuối cùng

  // Set để lưu index của các mục cha đang được mở rộng
  final Set<int> _expandedIndices = {};

  // Giả lập dữ liệu ban đầu
  final SideMenuData data = SideMenuData();

  @override
  void initState() {
    super.initState();
    // Chọn mục đầu tiên làm mặc định khi khởi động
    if (data.menu.isNotEmpty) {
      selectedMainMenuIndex = 0;
      selectedSubMenuIndex = null; // Không có submenu nào được chọn ban đầu
      selectedTitle = data.menu[0].title;
    }
  }

  void _handleSelection(int mainIndex, int? subIndex) {
    setState(() {
      selectedMainMenuIndex = mainIndex;
      selectedSubMenuIndex = subIndex;
      if (subIndex == null) {
        selectedTitle = data.menu[mainIndex].title;
      } else {
        selectedTitle = data.menu[mainIndex].subItems![subIndex].title;
      }
    });
    // Có thể thêm logic điều hướng ở đây dựa trên item được chọn
    print('Selected Title: $selectedTitle'); // DEBUG PRINT
  }

  void _toggleExpansion(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
    print(
      'Toggled Expansion for Index: $index, Expanded: ${_expandedIndices.contains(index)}',
    ); // DEBUG PRINT
  }

  @override
  Widget build(BuildContext context) {
    // Màu nền tối cho toàn bộ sidebar
    const sidebarBackgroundColor = cardBackgroundColor; // Màu xám tối ví dụ

    final unselectedColor = Colors.grey[400]!;
    // Màu chữ/icon khi được chọn
    const selectedColor = Colors.white; // Hoặc màu đen tùy thuộc selectionColor
    // Màu nền khi được chọn (điều chỉnh selectionColor nếu cần)
    final selectedBackgroundColor = selectionColor; // Lấy từ const của bạn

    return Container(
      color: sidebarBackgroundColor, // Nền tối cho toàn bộ menu
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Phần trên cùng ---
          Row(
            // Logo/Tên App
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
              ), // Logo placeholder
              SizedBox(width: 10),
              Text(
                "SaGu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Center(
            // Avatar
            child: CircleAvatar(
              radius: 35,
              // backgroundImage: NetworkImage('URL_TO_AVATAR'), // Thay bằng ảnh thật
              backgroundColor: Colors.grey[300], // Placeholder
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.grey[600],
              ), // Placeholder Icon
            ),
          ),
          const SizedBox(height: 10),
          Center(
            // Tên User
            child: Text(
              "Tâm Nguyễn",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 35),

          // --- Phần Menu Items (sử dụng Column thay vì ListView để dễ quản lý cấp) ---
          Expanded(
            child: SingleChildScrollView(
              // Cho phép cuộn nếu menu dài
              child: Column(
                children: List.generate(data.menu.length, (mainIndex) {
                  final menuItem = data.menu[mainIndex];
                  final bool isParentSelected =
                      selectedMainMenuIndex == mainIndex &&
                      selectedSubMenuIndex == null;
                  final bool isExpanded = _expandedIndices.contains(mainIndex);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Mục Cha ---
                      buildMenuEntry(
                        title: menuItem.title,
                        icon: menuItem.icon,
                        isSelected: isParentSelected,
                        hasSubItems:
                            menuItem.subItems != null &&
                            menuItem.subItems!.isNotEmpty,
                        isExpanded: isExpanded,
                        onTap: () {
                          print(
                            'Tapped on Main Menu: ${menuItem.title}',
                          ); // DEBUG PRINT
                          if (menuItem.subItems != null &&
                              menuItem.subItems!.isNotEmpty) {
                            _toggleExpansion(mainIndex);
                          } else {
                            // Chọn mục cha nếu không có con
                            _handleSelection(mainIndex, null);
                          }
                        },
                        onExpandTap: () {
                          print(
                            'Tapped on Expand for: ${menuItem.title}',
                          ); // DEBUG PRINT
                          _toggleExpansion(mainIndex);
                        }, // Xử lý tap vào icon expand
                        selectedBgColor: selectedBackgroundColor,
                        selectedFgColor: selectedColor,
                        unselectedFgColor: unselectedColor,
                      ),

                      // --- Mục Con (nếu có và đang mở rộng) ---
                      if (menuItem.subItems != null && isExpanded)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                          ), // Thụt lề mục con
                          child: Column(
                            children: List.generate(menuItem.subItems!.length, (
                              subIndex,
                            ) {
                              final subItem = menuItem.subItems![subIndex];
                              final bool isSubSelected =
                                  selectedMainMenuIndex == mainIndex &&
                                  selectedSubMenuIndex == subIndex;
                              return buildMenuEntry(
                                title: subItem.title,
                                dotColor:
                                    subItem
                                        .dotColor, // Dùng dotColor thay vì icon
                                isSelected: isSubSelected,
                                onTap: () {
                                  print(
                                    'Tapped on Sub Menu: ${subItem.title}',
                                  ); // DEBUG PRINT
                                  _handleSelection(mainIndex, subIndex);
                                },
                                selectedBgColor: selectedBackgroundColor,
                                selectedFgColor: selectedColor,
                                unselectedFgColor: unselectedColor,
                                isSubItem: true,
                              );
                            }),
                          ),
                        ),
                    ],
                  );
                }),
              ),
            ),
          ),

          // --- Phần dưới cùng ---
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add files",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Up to 20 GB",
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                SizedBox(height: 15),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Xử lý sự kiện Add files
                        print('Add files button pressed'); // DEBUG PRINT
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget để xây dựng từng mục menu (cha hoặc con)
  Widget buildMenuEntry({
    required String title,
    IconData? icon, // Nullable cho mục con
    Color? dotColor, // Cho mục con
    required bool isSelected,
    required VoidCallback onTap,
    VoidCallback? onExpandTap, // Cho nút expand/collapse
    bool hasSubItems = false,
    bool isExpanded = false,
    bool isSubItem = false, // Phân biệt mục cha/con
    required Color selectedBgColor,
    required Color selectedFgColor,
    required Color unselectedFgColor,
  }) {
    final fgColor =
        isSelected ? selectedFgColor : unselectedFgColor; // Màu chữ/icon

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ), // Khoảng cách giữa các mục
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ), // Bo góc lớn hơn
        color:
            isSelected
                ? selectedBgColor.withOpacity(0.9)
                : Colors.transparent, // Màu nền khi chọn
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: isSubItem ? 8 : 12,
          ), // Padding khác nhau cho cha/con
          child: Row(
            children: [
              // Icon hoặc Dấu chấm tròn
              if (isSubItem && dotColor != null) ...[
                CircleAvatar(radius: 4, backgroundColor: dotColor),
                const SizedBox(width: 29), // ~ Bằng padding icon + sizedbox
              ] else if (icon != null) ...[
                Padding(
                  // Giảm padding ngang của icon một chút
                  padding: const EdgeInsets.only(
                    right: 13.0,
                  ), // Chỉ cần padding bên phải icon
                  child: Icon(icon, size: 20, color: fgColor),
                ),
                // const SizedBox(width: 16), // Bỏ SizedBox, dùng padding phải của Icon
              ] else ...[
                // Trường hợp không có icon và không phải subitem (ít xảy ra)
                const SizedBox(width: 33), // Placeholder để căn lề text
              ],

              // Title
              Expanded(
                // Cho phép text chiếm hết không gian còn lại
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14, // Cỡ chữ nhỏ hơn
                    color: fgColor,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),

              // Icon Expand/Collapse (chỉ cho mục cha có subitems)
              if (hasSubItems && onExpandTap != null)
                InkWell(
                  onTap: onExpandTap, // Dùng hàm riêng cho nút này
                  child: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: unselectedFgColor, // Luôn là màu xám?
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
