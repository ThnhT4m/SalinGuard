import 'package:flutter/material.dart';
import 'package:sagu/const/constant.dart';
// Giả sử các import này đúng
import 'package:sagu/data/notification_data.dart';
import 'package:sagu/models/notification_model.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NotificationDataSource _dataSource = NotificationDataSource();

  @override
  void initState() {
    super.initState();
    // Độ dài length: 3 phải khớp với số lượng Tab và children của TabBarView
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: cardBackgroundColor,
      child: SafeArea(
        // SafeArea có thể không cần thiết nếu nó đã có trong MainScreen
        child: Column(
          // Column chính của NotificationWidget
          // mainAxisSize: MainAxisSize.min, // Bỏ dòng này đi nếu bạn muốn Column chiếm hết chiều cao được Expanded cung cấp
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
              // KIỂM TRA Ở ĐÂY: Nội dung của Row này có widget nào yêu cầu chiều rộng vô hạn không?
              // Ví dụ: Text quá dài trong Row?
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Ví dụ nội dung Header (Cần xem code thật của bạn)
                  const Text(
                    'Thông báo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelColor: secondaryColor, // Hoặc màu bạn muốn
              unselectedLabelColor: secondaryColor,
              indicatorColor: secondaryColor,
              // KIỂM TRA Ở ĐÂY: Đảm bảo các Tab không quá rộng
              tabs: const [
                Tab(text: 'Tất cả'),
                Tab(text: 'Nhóm'),
                Tab(text: 'Tài liệu'),
              ],
            ),
            const Divider(height: 1, thickness: 1, color: secondaryColor),

            // --- Tab Content ---
            // Expanded là RẤT QUAN TRỌNG ở đây để giới hạn chiều cao cho TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Trang 1: Danh sách thông báo
                  _buildNotificationList(_dataSource.sampleNotifications),

                  const Center(child: Text('Teams Notifications Content')),
                  const Center(child: Text('Documents Notifications Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(List<NotificationModel> items) {
    // ListView.separated thường hoạt động tốt khi có chiều cao giới hạn (nhờ Expanded ở trên)
    return ListView.separated(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (context, index) {
        // KIỂM TRA Ở ĐÂY: Hàm này tạo ra ListTile, lỗi có thể nằm bên trong ListTile
        return _buildNotificationListItem(items[index]);
      },
      separatorBuilder:
          (context, index) => const Divider(
            height: 1,
            thickness: 1,
            color: secondaryColor,
            indent: 72, // Thụt lề cho đường kẻ
            endIndent: 16,
          ),
    );
  }

  Widget _buildNotificationListItem(NotificationModel item) {
    // KIỂM TRA Ở ĐÂY: Cấu trúc bên trong ListTile này.
    // Có Row chứa Text dài không? Có widget nào yêu cầu không gian vô hạn không?
    // Ví dụ đơn giản:
    return ListTile(
      leading: CircleAvatar(
        // child: Text(item.senderInitial ?? '?'), // Placeholder
        backgroundImage: NetworkImage(
          item.imageUrl ?? 'https://via.placeholder.com/150',
        ), // Sử dụng avatarUrl nếu có
        backgroundColor: secondaryColor, // Màu nền nếu không có ảnh
      ),
      title: Text(
        item.timeAgo ?? 'Không có tiêu đề',
        maxLines: 1, // Giới hạn 1 dòng
        overflow: TextOverflow.ellipsis, // Thêm dấu ... nếu quá dài
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        item.category ?? 'Không có nội dung',
        maxLines: 2, // Giới hạn 2 dòng
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        item.timeAgo ?? '', // Hiển thị thời gian
        style: const TextStyle(fontSize: 12, color: secondaryColor),
      ),
      onTap: () {
        // Xử lý khi nhấn vào thông báo
      },
    );
    // Nếu ListTile của bạn phức tạp hơn nhiều, hãy kiểm tra kỹ các Row, Column, Text bên trong nó.
  }
}
