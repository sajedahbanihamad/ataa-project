import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminNotifications extends StatefulWidget {
  const AdminNotifications({super.key});

  @override
  State<AdminNotifications> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<AdminNotifications> {
  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();

    notifications = [
      {
        "id": 1,
        "icon": LucideIcons.dollarSign,
        "bg": const Color(0xFFEFF6FF),
        "color": const Color(0xFF2563EB),
        "message": "New donation submitted",
        "detail": "John Doe posted a Food donation",
        "time": "5 min ago",
        "unread": true,
      },
      {
        "id": 2,
        "icon": LucideIcons.alertTriangle,
        "bg": const Color(0xFFFEF2F2),
        "color": const Color(0xFFDC2626),
        "message": "Donation flagged",
        "detail": "Unusual activity detected on donation #1234",
        "time": "15 min ago",
        "unread": true,
      },
      {
        "id": 3,
        "icon": LucideIcons.userPlus,
        "bg": const Color(0xFFF5F3FF),
        "color": const Color(0xFF9333EA),
        "message": "New charity registered",
        "detail": "Save Lives Foundation joined the platform",
        "time": "1 hour ago",
        "unread": true,
      },
      {
        "id": 4,
        "icon": LucideIcons.checkCircle,
        "bg": const Color(0xFFECFDF5),
        "color": const Color(0xFF16A34A),
        "message": "Donation completed",
        "detail": "Food Bank Network completed donation #1228",
        "time": "2 hours ago",
        "unread": false,
      },
      {
        "id": 5,
        "icon": LucideIcons.clock,
        "bg": const Color(0xFFFFF7ED),
        "color": const Color(0xFFEA580C),
        "message": "Donation accepted",
        "detail": "Hope Foundation accepted donation #1226",
        "time": "3 hours ago",
        "unread": false,
      },
    ];
  }

  void markAsRead(int index) {
    setState(() {
      notifications[index]["unread"] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// Header
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(LucideIcons.arrowLeft, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Notifications List
            ...notifications.asMap().entries.map((entry) {
              int index = entry.key;
              var n = entry.value;

              return GestureDetector(
                onTap: () => markAsRead(index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: n["unread"]
                          ? const Color(0xFF529160)
                          : Colors.grey.shade200,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4)
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: n["bg"],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          n["icon"],
                          size: 20,
                          color: n["color"],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    n["message"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                if (n["unread"])
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF529160),
                                      shape: BoxShape.circle,
                                    ),
                                  )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              n["detail"],
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              n["time"],
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
