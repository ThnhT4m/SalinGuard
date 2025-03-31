import 'package:flutter/material.dart';
import 'package:sagu/const/constant.dart';
import 'package:sagu/util/responsive.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Menu Icon (Mobile & Tablet)
        if (!Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(Icons.menu, color: Colors.grey, size: 25),
              ),
            ),
          ),

        // Search Bar (Desktop Only)
        if (Responsive.isDesktop(context))
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: cardBackgroundColor,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                hintText: 'Search',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 21,
                ),
              ),
            ),
          ),

        // Notification Icon (Mobile & Tablet)
        if (!Responsive.isDesktop(context))
          InkWell(
            onTap: () => Scaffold.of(context).openEndDrawer(),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: const Icon(
                Icons.notification_add,
                color: Colors.grey,
                size: 25,
              ),
            ),
          ),
      ],
    );
  }
}
