// lib/const/constant.dart
import 'package:flutter/material.dart';

// Colors
const cardBackgroundColor = Color(0xFF21222D);
const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFFFFFFFF);
const backgroundColor = Color(0xFF15131C);
const selectionColor = Color(0xFF88B2AC);

// Padding
const double defaultPadding = 16.0; // Giữ nguyên hoặc điều chỉnh
const double itemPadding = 10.0; // Ví dụ thêm padding cho các item
const double horizontalPadding = 20.0;
const double verticalPadding = 15.0;

// Text Styles (Ví dụ)
const TextStyle kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: secondaryColor,
);

const TextStyle kSubtitleTextStyle = TextStyle(
  fontSize: 14,
  color: secondaryColor,
);

// Border Radius
const BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(10));
const BorderRadius cardBorderRadius = BorderRadius.all(Radius.circular(15));

// Durations (Cho animations)
const Duration defaultDuration = Duration(milliseconds: 300);

// Bạn có thể thêm các hằng số khác nếu cần
