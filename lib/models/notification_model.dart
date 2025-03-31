class NotificationModel {
  final String imageUrl; // Đường dẫn ảnh avatar
  final String content; // Nội dung chính của thông báo
  final String category; // Loại thông báo (e.g., "Project")
  final String timeAgo; // Thời gian (e.g., "5 min ago")
  final bool isUnread; // Trạng thái chưa đọc (cho dấu chấm xanh)

  NotificationModel({
    required this.imageUrl,
    required this.content,
    required this.category,
    required this.timeAgo,
    this.isUnread = false,
  });
}
