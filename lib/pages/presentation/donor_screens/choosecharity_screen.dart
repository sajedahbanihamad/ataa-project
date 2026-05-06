import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChooseCharityScreen extends StatelessWidget {
  const ChooseCharityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final charities = [
      {
        "id": 1,
        "name": "Food Bank Central",
        "distance": "1.2 miles",
        "rating": 4.9,
        "reviews": 328,
        "impact": "High",
        "cause": "Fighting Hunger",
        "verified": true,
      },
      {
        "id": 2,
        "name": "Community Food Pantry",
        "distance": "2.5 miles",
        "rating": 4.8,
        "reviews": 215,
        "impact": "High",
        "cause": "Local Support",
        "verified": true,
      },
      {
        "id": 3,
        "name": "Hope Kitchen",
        "distance": "3.8 miles",
        "rating": 4.7,
        "reviews": 142,
        "impact": "Medium",
        "cause": "Meal Programs",
        "verified": false,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              /// Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(LucideIcons.arrowLeft, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Choose Charity",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Search
              Stack(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search charities...",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.fromLTRB(40, 12, 16, 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: Color(0xFF529160), width: 2),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 12,
                    top: 12,
                    child: Icon(LucideIcons.search, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Top Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${charities.length} charities near you",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/Ai-match-screen');
                    },
                    child: Row(
                      children: const [
                        Icon(LucideIcons.trendingUp,
                            size: 16, color: Color(0xFF529160)),
                        SizedBox(width: 4),
                        Text(
                          "Try AI Match",
                          style: TextStyle(color: Color(0xFF529160)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// List
              Expanded(
                child: ListView.separated(
                  itemCount: charities.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final c = charities[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/confirmation_screen',
                          arguments: {
                            "charity": c["name"],
                            "aiMatch": false,
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Title + Verified
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    c["name"] as String,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                if (c["verified"] as bool)
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  )
                              ],
                            ),

                            const SizedBox(height: 4),

                            Text(
                              c["cause"] as String,
                              style: const TextStyle(color: Colors.grey),
                            ),

                            const SizedBox(height: 10),

                            /// Distance + Rating
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(LucideIcons.mapPin,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text(c["distance"] as String),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  children: [
                                    const Icon(LucideIcons.star,
                                        size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text("${c["rating"]}"),
                                    const SizedBox(width: 2),
                                    Text("(${c["reviews"]})",
                                        style: const TextStyle(
                                            color: Colors.grey)),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            /// Impact
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (c["impact"] == "High")
                                    ? Colors.green.shade100
                                    : Colors.yellow.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "${c["impact"]} Impact",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: (c["impact"] == "High")
                                      ? Colors.green.shade700
                                      : Colors.yellow.shade700,
                                ),
                              ),
                            )
                          ],
                        ),
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
