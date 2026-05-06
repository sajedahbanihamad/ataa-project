import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        "label": "Total Donations",
        "value": "2,458",
        "icon": LucideIcons.dollarSign,
        "color": const Color(0xFFEFF6FF),
        "iconColor": const Color(0xFF2563EB),
      },
      {
        "label": "Active Donations",
        "value": "142",
        "icon": LucideIcons.clock,
        "color": const Color(0xFFFFF7ED),
        "iconColor": const Color(0xFFEA580C),
      },
      {
        "label": "Completed",
        "value": "2,208",
        "icon": LucideIcons.checkCircle,
        "color": const Color(0xFFECFDF5),
        "iconColor": const Color(0xFF16A34A),
      },
      {
        "label": "Total Users",
        "value": "834",
        "icon": LucideIcons.users,
        "color": const Color(0xFFF5F3FF),
        "iconColor": const Color(0xFF9333EA),
      },
    ];

    final recentActivity = [
      {
        "action": "New donation submitted",
        "user": "John Doe",
        "time": "5 min ago",
        "type": "donation"
      },
      {
        "action": "Donation accepted",
        "user": "Hope Charity",
        "time": "12 min ago",
        "type": "accepted"
      },
      {
        "action": "New charity registered",
        "user": "Save Lives Foundation",
        "time": "1 hour ago",
        "type": "user"
      },
      {
        "action": "Donation completed",
        "user": "Food Bank Network",
        "time": "2 hours ago",
        "type": "completed"
      },
      {
        "action": "Donation flagged",
        "user": "System Alert",
        "time": "3 hours ago",
        "type": "flagged"
      },
    ];

    Color getDotColor(String type) {
      switch (type) {
        case 'donation':
          return Colors.blue;
        case 'accepted':
          return const Color(0xFF529160);
        case 'completed':
          return Colors.green;
        case 'flagged':
          return Colors.red;
        default:
          return Colors.purple;
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// Stats Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stats.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                final stat = stats[index];
                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: stat["color"] as Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          stat["icon"] as IconData,
                          size: 20,
                          color: stat["iconColor"] as Color,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        stat["value"] as String,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat["label"] as String,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            /// Recent Activity
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: const Text(
                      "Recent Activity",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...recentActivity.map((activity) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade100)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: getDotColor(activity["type"] as String),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity["action"] as String,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  activity["user"] as String,
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            activity["time"] as String,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Donation Progress
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Donation Progress",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  buildProgress("Food", "856", 0.75),
                  buildProgress("Clothes", "634", 0.60),
                  buildProgress("Money", "968", 0.85),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgress(String title, String value, double progress) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation(Color(0xFF529160)),
            ),
          ),
        ],
      ),
    );
  }
}
