import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UserDetailsScreen extends StatelessWidget {
  final String id;
  const UserDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final user = {
      "id": id,
      "name": "John Doe",
      "type": "Donor",
      "email": "john.doe@email.com",
      "phone": "+1 234 567 8900",
      "location": "New York, NY",
      "rating": 4.8,
      "status": "Active",
      "joinDate": "Jan 15, 2024",
      "totalDonations": 24,
      "recentActivity": [
        {"type": "Food", "date": "Apr 30, 2026", "status": "Accepted"},
        {"type": "Clothes", "date": "Apr 28, 2026", "status": "Completed"},
        {"type": "Money", "date": "Apr 25, 2026", "status": "Completed"},
        {"type": "Books", "date": "Apr 22, 2026", "status": "Completed"},
        {"type": "Food", "date": "Apr 20, 2026", "status": "Completed"},
      ],
    };

    Color getStatusBg(String status) {
      switch (status) {
        case "Accepted":
          return Colors.blue.shade100;
        case "Completed":
          return Colors.green.shade100;
        default:
          return Colors.grey.shade200;
      }
    }

    Color getStatusText(String status) {
      switch (status) {
        case "Accepted":
          return Colors.blue;
        case "Completed":
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

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
                  "User Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Profile Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ],
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          "JD",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user["name"] as String,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(user["type"] as String,
                                style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(LucideIcons.star,
                                    size: 16, color: Colors.orange),
                                const SizedBox(width: 4),
                                Text(user["rating"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: user["status"] == "Active"
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    user["status"] as String,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: user["status"] == "Active"
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  buildInfoRow(LucideIcons.mail, user["email"] as String),
                  buildInfoRow(LucideIcons.phone, user["phone"] as String),
                  buildInfoRow(LucideIcons.mapPin, user["location"] as String),
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Stats
            Row(
              children: [
                buildStat("Member Since", user["joinDate"] as String),
                const SizedBox(width: 8),
                buildStat("Total Donations", user["totalDonations"].toString()),
              ],
            ),

            const SizedBox(height: 12),

            /// Recent Activity
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    child: const Text("Recent Activity",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ...((user["recentActivity"] as List).map((activity) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${activity["type"]} Donation",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              Text(activity["date"] as String,
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: getStatusBg(activity["status"] as String),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              activity["status"] as String,
                              style: TextStyle(
                                fontSize: 11,
                                color:
                                    getStatusText(activity["status"] as String),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }))
                ],
              ),
            ),

            const SizedBox(height: 12),

            /// Admin Controls
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Text("Admin Controls",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  if (user["status"] == "Active")
                    buildButton("Suspend Account", LucideIcons.ban,
                        Colors.white, Colors.orange,
                        border: true, borderColor: Colors.orange)
                  else
                    buildButton("Activate Account", LucideIcons.checkCircle,
                        const Color(0xFF529160), Colors.white),
                  buildButton("Delete Account", LucideIcons.trash2,
                      Colors.white, Colors.red,
                      border: true, borderColor: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 6),
          Text(text),
        ],
      ),
    );
  }

  Widget buildStat(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, IconData icon, Color bg, Color textColor,
      {bool border = false, Color? borderColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: textColor,
          side: border
              ? BorderSide(color: borderColor ?? Colors.grey)
              : BorderSide.none,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {},
        icon: Icon(icon, size: 18),
        label: Text(text),
      ),
    );
  }
}
