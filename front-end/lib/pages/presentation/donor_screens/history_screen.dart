import 'package:flutter/material.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final donations = [
      {
        "id": "DON-1A2B3C",
        "charity": "Food Bank Central",
        "category": "Food",
        "items": "10 meal boxes",
        "date": "Apr 25, 2026",
        "status": "Delivered",
      },
      {
        "id": "DON-4D5E6F",
        "charity": "Clothes for Hope",
        "category": "Clothing",
        "items": "3 bags",
        "date": "Apr 20, 2026",
        "status": "Delivered",
      },
      {
        "id": "DON-7G8H9I",
        "charity": "Books for Kids",
        "category": "Books",
        "items": "15 books",
        "date": "Apr 15, 2026",
        "status": "Delivered",
      },
      {
        "id": "DON-0J1K2L",
        "charity": "Tech for All",
        "category": "Electronics",
        "items": "2 laptops",
        "date": "Apr 10, 2026",
        "status": "Delivered",
      },
      {
        "id": "DON-3M4N5O",
        "charity": "Healthcare Heroes",
        "category": "Medicine",
        "items": "Medical supplies",
        "date": "Apr 5, 2026",
        "status": "Delivered",
      },
    ];

    final stats = [
      {"label": "Total Donations", "value": "28", "icon": Icons.favorite},
      {"label": "Items Donated", "value": "124", "icon": Icons.calendar_today},
      {"label": "Community Impact", "value": "850", "icon": Icons.emoji_events},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Donation History",
                style: TextStyle(fontSize: 24),
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
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: donations.length,
                  itemBuilder: (context, index) {
                    final donation = donations[index];

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ID: ${donation["id"]}",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  donation["status"] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
