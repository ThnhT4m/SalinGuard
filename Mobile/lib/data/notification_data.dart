import 'package:sagu/models/notification_model.dart';

// Class để chứa hoặc cung cấp dữ liệu thông báo
class NotificationDataSource {
  // Danh sách dữ liệu mẫu giờ là một thành viên của class
  // Dùng final nếu danh sách này không thay đổi sau khi khởi tạo
  final List<NotificationModel> sampleNotifications = [
    NotificationModel(
      imageUrl: 'https://via.placeholder.com/150/92c952',
      content:
          'Sulastri Silami requests permission to change Project - Nganter App',
      category: 'Project',
      timeAgo: '5 min ago',
      isUnread: false,
    ),
    NotificationModel(
      imageUrl: 'https://via.placeholder.com/150/771796',
      content:
          'Michael Dandi requests permission to change Project - Andromeda Website',
      category: 'Project',
      timeAgo: '21 min ago',
      isUnread: true,
    ),
    NotificationModel(
      imageUrl: 'https://via.placeholder.com/150/24f355',
      content: 'Suminah has add new project Pakir App',
      category: 'Project',
      timeAgo: '24 min ago',
      isUnread: false,
    ),
    NotificationModel(
      imageUrl: 'https://via.placeholder.com/150/d32776',
      content: 'Tri Utomo has just added a new employee',
      category: 'Employee',
      timeAgo: '30 min ago',
      isUnread: false,
    ),
    NotificationModel(
      imageUrl: 'https://via.placeholder.com/150/f66b97',
      content: 'Bambang S. has added a new vendor and changed the client',
      category: 'Vendor & Client',
      timeAgo: '1 hour ago',
      isUnread: false,
    ),
    NotificationModel(
      imageUrl: 'https://via.placeholder.com/150/56a8c2',
      content: 'Bambang S. has added a new client',
      category: 'Client',
      timeAgo: '2 hours ago',
      isUnread: false,
    ),
    // Thêm các mục thông báo khác nếu cần
  ];

  // Trong tương lai, bạn có thể thêm các phương thức vào đây
  // ví dụ: Future<List<NotificationItem>> fetchNotifications() { ... }
}
