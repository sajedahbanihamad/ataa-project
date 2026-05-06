import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"label": "Total Donations", "value": "28", "icon": Icons.favorite},
      {"label": "Items Donated", "value": "124", "icon": Icons.inventory},
      {"label": "Community Rating", "value": "4.9", "icon": Icons.trending_up},
    ];

    final recentDonations = [
      {
        "id": 1,
        "charity": "Food Bank Central",
        "category": "Food",
        "items": "10 meal boxes",
        "date": "Apr 25",
        "status": "Delivered"
      },
      {
        "id": 2,
        "charity": "Clothes for Hope",
        "category": "Clothing",
        "items": "3 bags",
        "date": "Apr 20",
        "status": "In Transit"
      },
      {
        "id": 3,
        "charity": "Books for Kids",
        "category": "Books",
        "items": "15 books",
        "date": "Apr 15",
        "status": "Delivered"
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          // ✅ التعديل: إزالة الـ padding السفلي الكبير لأن الـ BottomNav صار في MainScreen
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Sarah Johnson",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/notifications_screen');
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF3F4F6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.notifications, size: 20),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF529160),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: stats.map((stat) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF529160), width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(stat["icon"] as IconData,
                              color: const Color(0xFF529160), size: 20),
                          const SizedBox(height: 8),
                          Text(
                            stat["value"] as String,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF529160),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stat["label"] as String,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Recent Donations",
                      style: TextStyle(fontSize: 18)),
                  // ✅ "See All" بينقل على شاشة History
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/history_screen');
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(color: Color(0xFF529160)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: recentDonations.length,
                  itemBuilder: (context, index) {
                    final donation = recentDonations[index];
                    final isDelivered = donation["status"] == "Delivered";

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      donation["charity"] as String,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${donation["category"]} • ${donation["items"]}",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                donation["date"] as String,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDelivered
                                  ? Colors.green.shade100
                                  : Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              donation["status"] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDelivered
                                    ? Colors.green.shade700
                                    : Colors.blue.shade700,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
