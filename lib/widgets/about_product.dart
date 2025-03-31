// Import package vừa thêm
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sagu/const/constant.dart';

class AboutProduct extends StatelessWidget {
  const AboutProduct({super.key});

  // Lưu chuỗi văn bản vào một biến const để dễ quản lý
  static const String _subtitleText = "Easy to respond to saltwater intrusion";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Định nghĩa style cho phụ đề một lần để tái sử dụng
    final subtitleStyle =
        textTheme.bodyLarge?.copyWith(color: secondaryColor, height: 1.0) ??
        TextStyle(
          // Fallback style
          fontSize: 16.0,
          color: secondaryColor,
          height: 1.4,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Tiêu đề (Giữ nguyên) ---
          Text(
            "Salinity intrusion \nmonitoring system",
            style:
                textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                  height: 1.3,
                ) ??
                const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: secondaryColor,
                  height: 1.3,
                ),
          ),
          const SizedBox(height: 16.0),

          // --- Phụ đề với hiệu ứng gõ chữ ---
          // Sử dụng AnimatedTextKit thay vì Text thông thường
          SizedBox(
            // Thêm SizedBox để giới hạn chiều cao nếu cần, tránh nhảy layout
            height: 50, // Chiều cao đủ cho 2 dòng text, điều chỉnh nếu cần
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  _subtitleText, // Chuỗi văn bản cần chạy hiệu ứng
                  textStyle: subtitleStyle, // Áp dụng style đã định nghĩa
                  speed: const Duration(
                    milliseconds: 60,
                  ), // Tốc độ gõ (ms/ký tự)
                  cursor: '_', // Ký tự con trỏ (có thể đổi thành '|' hoặc '')
                ),
              ],
              totalRepeatCount: 2, // Chỉ chạy hiệu ứng 1 lần
              pause: const Duration(
                milliseconds: 1000,
              ), // Thời gian chờ trước khi bắt đầu (tùy chọn)
              displayFullTextOnTap:
                  true, // Nhấn vào để hiển thị toàn bộ text ngay lập tức
              stopPauseOnTap: true, // Nhấn vào để bỏ qua thời gian chờ ban đầu
            ),
          ),
        ],
      ),
    );
  }
}
