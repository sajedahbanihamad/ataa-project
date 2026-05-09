import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:Ataa/pages/presentation/admin_screens/admin_dashboard.dart';
import 'package:Ataa/pages/presentation/admin_screens/admin_donations.dart';
import 'package:Ataa/pages/presentation/admin_screens/admin_profile.dart';
import 'package:Ataa/pages/presentation/admin_screens/report_screen.dart';
import 'package:Ataa/pages/presentation/admin_screens/users_screen.dart';
import 'package:Ataa/pages/presentation/admin_screens/admin_notifications.dart';

class MainAdminscreen extends StatefulWidget {
  const MainAdminscreen({super.key});

  @override
  State<MainAdminscreen> createState() => _MainAdminscreenState();
}

class _MainAdminscreenState extends State<MainAdminscreen> {
  int _currentIndex = 0;

  final screens = const [
    AdminDashboard(),
    AdminDonations(),
    UsersScreen(),
    ReportsScreen(),
    AdminProfile(),
  ];

  final navItems = [
    {"icon": LucideIcons.home, "label": "Dashboard"},
    {"icon": LucideIcons.dollarSign, "label": "Donations"},
    {"icon": LucideIcons.users, "label": "Users"},
    {"icon": LucideIcons.fileBarChart, "label": "Reports"},
    {"icon": LucideIcons.user, "label": "Profile"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bell),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminNotifications(),
                ),
              );
            },
          )
        ],
      ),

      /// ✅ هنا التبديل بين الصفحات
      body: screens[_currentIndex],

      /// Bottom Navigation
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(navItems.length, (index) {
            final item = navItems[index];
            final isActive = index == _currentIndex;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item["icon"] as IconData,
                    color: isActive ? const Color(0xFF529160) : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item["label"] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: isActive ? const Color(0xFF529160) : Colors.grey,
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
