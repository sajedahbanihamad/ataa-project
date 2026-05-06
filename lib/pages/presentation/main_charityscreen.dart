import 'package:Ataa/pages/presentation/charity_screens/donations_screen2.dart';
import 'package:Ataa/pages/presentation/charity_screens/history_screen2.dart';
import 'package:Ataa/pages/presentation/charity_screens/dashboard_screen.dart';
import 'package:Ataa/pages/presentation/charity_screens/profile_screen2.dart';
import 'package:Ataa/pages/presentation/charity_screens/notifications_screen2.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MaincharityScreen extends StatefulWidget {
  const MaincharityScreen({super.key});

  @override
  State<MaincharityScreen> createState() => _MaincharityScreenState();
}

class _MaincharityScreenState extends State<MaincharityScreen> {
  String activeTab = "home";
  int notificationCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      /// TOP BAR
      appBar: _topBar(),

      /// BODY
      body: SafeArea(
        child: _getScreen(),
      ),

      /// BOTTOM NAV
      bottomNavigationBar: _bottomNav(),
    );
  }

  /// ================= TOP BAR =================
  PreferredSizeWidget _topBar() {
    String title;

    switch (activeTab) {
      case "donations":
        title = "My Donations";
        break;
      case "history":
        title = "History";
        break;
      case "profile":
        title = "Profile";
        break;
      case "notification":
        title = "Notifications";
        break;
      default:
        title = "Dashboard";
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF111827),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,

      /// NOTIFICATION ICON
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                LucideIcons.bell,
                color: Color(0xFF374151),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CharityNotificationsScreen(),
                  ),
                );

                if (result == true) {
                  setState(() {
                    notificationCount = 0;
                  });
                }
              },
            ),

            /// Badge
            if (notificationCount > 0)
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFF529160),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  /// ================= BODY =================
  Widget _getScreen() {
    switch (activeTab) {
      case "donations":
        return const MyDonationsScreen();
      case "history":
        return const CharityHistoryScreen();
      case "profile":
        return const CharityProfileScreen();
      case "home":
        return const CharityHomeScreen();
      default:
        return const CharityHomeScreen();
    }
  }

  /// ================= BOTTOM NAV =================
  Widget _bottomNav() {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE5E7EB)),
        ),
      ),
      child: Row(
        children: [
          _navItem("home", "Dashboard", LucideIcons.home),
          _navItem("donations", "My Donations", LucideIcons.package),
          _navItem("history", "History", LucideIcons.clock),
          _navItem("profile", "Profile", LucideIcons.user),
        ],
      ),
    );
  }

  Widget _navItem(String id, String label, IconData icon) {
    final isActive = activeTab == id;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            activeTab = id;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color:
                  isActive ? const Color(0xFF529160) : const Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isActive
                    ? const Color(0xFF529160)
                    : const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
