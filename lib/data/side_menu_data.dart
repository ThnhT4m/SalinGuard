import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart'; // Ví dụ dùng thư viện icon khác
import 'package:sagu/models/menu_model.dart'; // Đảm bảo đường dẫn đúng

class SideMenuData {
  final menu = <MenuModel>[
    MenuModel(
      icon: MaterialCommunityIcons.view_dashboard_outline,
      title: 'Dashboard',
    ),
    MenuModel(
      icon: MaterialCommunityIcons.folder_outline,
      title: 'Systems',
      subItems: <MenuModel>[
        MenuModel(title: 'pH level', dotColor: Colors.blue),
        MenuModel(title: 'Salinity', dotColor: Colors.red),
        MenuModel(title: 'Water level', dotColor: Colors.orange),
        MenuModel(title: 'Turbidity', dotColor: Colors.yellow),
      ],
    ),

    MenuModel(icon: MaterialCommunityIcons.cog_outline, title: 'Settings'),
  ];
}
