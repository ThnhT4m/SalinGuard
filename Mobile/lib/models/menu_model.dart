import 'package:flutter/material.dart';

class MenuModel {
  final IconData? icon; // Icon có thể null cho mục con dùng dot
  final String title;
  final List<MenuModel>? subItems; // Danh sách các mục con
  final Color? dotColor; // Màu cho dấu chấm của mục con

  MenuModel({this.icon, required this.title, this.subItems, this.dotColor});
}
