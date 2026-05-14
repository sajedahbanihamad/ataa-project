import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "id": 1,
        "icon": LucideIcons.checkCircle2,
        "title": "Donation Delivered",
        "message":
            "Your donation to Food Bank Central has been delivered successfully",
        "time": "2 hours ago",
        "read": false,
      },
      {
        "id": 2,
        "icon": LucideIcons.package,
        "title": "Pickup Scheduled",
        "message":
            "Your donation will be picked up tomorrow between 10 AM - 2 PM",
        "time": "5 hours ago",
        "read": false,
      },
      {
        "id": 3,
        "icon": LucideIcons.trendingUp,
        "title": "Impact Milestone",
        "message":
            "You've helped 50+ families this month! Keep up the great work",
        "time": "1 day ago",
        "read": true,
      },
      {
        "id": 4,
        "icon": LucideIcons.gift,
        "title": "New Donation Request",
        "message":
            "Clothes for Hope is looking for clothing donations in your area",
        "time": "2 days ago",
        "read": true,
      },
      {
        "id": 5,
        "icon": LucideIcons.checkCircle2,
        "title": "Charity Accepted Donation",
        "message": "Books for Kids accepted your donation request",
        "time": "3 days ago",
        "read": true,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                const SizedBox(height: 24),

                /// Notifications List
                Expanded(
                  child: ListView.separated(
                    itemCount: notifications.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final n = notifications[index];

                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Icon Box
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF529160).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                n["icon"] as IconData,
                                color: const Color(0xFF529160),
                                size: 24,
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          n["title"] as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      if (!(n["read"] as bool))
                                        Container(
                                          width: 10,
                                          height: 10,
                                          margin: const EdgeInsets.only(top: 6),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF529160),
                                            shape: BoxShape.circle,
                                          ),
                                        )
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    n["message"] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      height: 1.4,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    n["time"] as String,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          /// Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(Icons.home_outlined, "Home"),
                  _navItem(Icons.add, "Donate"),
                  _navItem(Icons.history, "History"),
                  _navItem(Icons.person, "Profile"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
