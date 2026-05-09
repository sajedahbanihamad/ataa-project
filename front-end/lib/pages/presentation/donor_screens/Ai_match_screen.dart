import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AIMatchSuggestionScreen extends StatelessWidget {
  const AIMatchSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topMatch = {
      "name": "Food Bank Central",
      "distance": "1.2 miles",
      "rating": 4.9,
      "reviews": 328,
      "matchScore": 98,
      "cause": "Fighting Hunger",
    };

    final matchReasons = [
      {
        "icon": LucideIcons.mapPin,
        "label": "Closest to you",
        "detail": "Only 1.2 miles away"
      },
      {
        "icon": LucideIcons.star,
        "label": "Highest rated",
        "detail": "4.9/5.0 from 328 reviews"
      },
      {
        "icon": LucideIcons.trendingUp,
        "label": "High need",
        "detail": "Currently needs food donations"
      },
      {
        "icon": LucideIcons.target,
        "label": "Perfect match",
        "detail": "Specializes in food distribution"
      },
    ];

    final alternativeMatches = [
      {
        "name": "Community Food Pantry",
        "distance": "2.5 miles",
        "rating": 4.8,
        "matchScore": 92
      },
      {
        "name": "Hope Kitchen",
        "distance": "3.8 miles",
        "rating": 4.7,
        "matchScore": 85
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Header
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(LucideIcons.arrowLeft),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "AI Match",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Top Match Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF529160), Color(0xFF3D6D48)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(LucideIcons.sparkles, color: Colors.white),
                          SizedBox(width: 6),
                          Text(
                            "Best Match",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  topMatch["name"] as String,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  topMatch["cause"] as String,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${topMatch["matchScore"]}%",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Match",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white24),
                          ),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                const Icon(LucideIcons.mapPin,
                                    size: 16, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(topMatch["distance"] as String,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                const Icon(LucideIcons.star,
                                    size: 16, color: Colors.white),
                                const SizedBox(width: 4),
                                Text("${topMatch["rating"]}",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                const SizedBox(width: 4),
                                Text(
                                  "(${topMatch["reviews"]})",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Reasons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Why this match?",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 12),
                    Column(
                      children: matchReasons.map((r) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF529160).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  r["icon"] as IconData,
                                  color: const Color(0xFF529160),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(r["label"] as String),
                                    Text(
                                      r["detail"] as String,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                /// Alternatives
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alternative Matches",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                    Column(
                      children: alternativeMatches.map((c) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(c["name"] as String),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(LucideIcons.mapPin,
                                            size: 12),
                                        const SizedBox(width: 4),
                                        Text(c["distance"] as String,
                                            style:
                                                const TextStyle(fontSize: 12)),
                                        const SizedBox(width: 10),
                                        const Icon(LucideIcons.star, size: 12),
                                        const SizedBox(width: 4),
                                        Text("${c["rating"]}",
                                            style:
                                                const TextStyle(fontSize: 12)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text("${c["matchScore"]}%",
                                      style: const TextStyle(
                                          color: Color(0xFF529160))),
                                  const SizedBox(width: 6),
                                  const Icon(LucideIcons.chevronRight,
                                      color: Colors.grey),
                                ],
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),

                const SizedBox(height: 20),

                /// Buttons
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/confirmation',
                            arguments: topMatch["name"]);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF529160),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(LucideIcons.award, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Donate to Best Match",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
