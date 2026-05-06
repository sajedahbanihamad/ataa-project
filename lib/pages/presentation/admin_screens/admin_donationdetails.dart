import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminDonationdetails extends StatelessWidget {
  final String id;
  const AdminDonationdetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final donation = {
      "id": id,
      "category": "Food",
      "description":
          "50 kg of rice, 30 kg of lentils, and canned vegetables. All items are unopened and well within expiry dates. Perfect for families in need.",
      "donor": {"name": "John Doe", "rating": 4.8, "phone": "+1 234 567 8900"},
      "charity": {
        "name": "Food Bank Network",
        "rating": 4.9,
        "phone": "+1 234 567 8901"
      },
      "location": "Downtown Community Center, 123 Main St",
      "status": "Accepted",
      "timeline": [
        {
          "label": "Donation Submitted",
          "date": "Apr 30, 2026 - 10:30 AM",
          "completed": true
        },
        {
          "label": "Under Review",
          "date": "Apr 30, 2026 - 10:45 AM",
          "completed": true
        },
        {
          "label": "Assigned to Charity",
          "date": "Apr 30, 2026 - 11:20 AM",
          "completed": true
        },
        {"label": "In Progress", "date": "Current", "completed": false},
        {"label": "Completed", "date": "Pending", "completed": false},
      ],
    };

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
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(LucideIcons.arrowLeft, size: 20),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Donation Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// Main Info
            buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF529160),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text("F",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(donation["category"] as String,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              donation["status"] as String,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.blue),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(donation["description"] as String),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(LucideIcons.mapPin, size: 16),
                      const SizedBox(width: 6),
                      Expanded(child: Text(donation["location"] as String)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(LucideIcons.calendar, size: 16),
                      SizedBox(width: 6),
                      Text("Apr 30, 2026"),
                    ],
                  ),
                ],
              ),
            ),

            /// Donor Info
            buildCard(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(LucideIcons.user, size: 16),
                      SizedBox(width: 6),
                      Text("Donor Information",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildPersonRow(donation["donor"] as Map),
                ],
              ),
            ),

            /// Charity Info
            buildCard(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(LucideIcons.building2, size: 16),
                      SizedBox(width: 6),
                      Text("Assigned Charity",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildPersonRow(donation["charity"] as Map),
                ],
              ),
            ),

            /// Timeline
            buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Status Timeline",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ...List.generate((donation["timeline"] as List).length,
                      (index) {
                    final step = (donation["timeline"] as List)[index] as Map;
                    final completed = step["completed"] as bool;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: completed
                                    ? const Color(0xFF529160)
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                              child: completed
                                  ? const Icon(LucideIcons.checkCircle,
                                      size: 14, color: Colors.white)
                                  : null,
                            ),
                            if (index !=
                                (donation["timeline"] as List).length - 1)
                              Container(
                                width: 2,
                                height: 30,
                                color: completed
                                    ? const Color(0xFF529160)
                                    : Colors.grey[300],
                              )
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step["label"] as String,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        completed ? Colors.black : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(step["date"] as String,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  })
                ],
              ),
            ),

            /// Admin Actions
            buildCard(
              child: Column(
                children: [
                  const Text("Admin Actions",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  buildButton("Approve Donation", LucideIcons.checkCircle,
                      const Color(0xFF529160), Colors.white),
                  buildButton("Reassign Charity", LucideIcons.userPlus,
                      Colors.white, Colors.black,
                      border: true),
                  buildButton("Reject Donation", LucideIcons.xCircle,
                      Colors.white, Colors.black,
                      border: true),
                  buildButton("Remove Donation", LucideIcons.trash2,
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

  Widget buildCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: child,
    );
  }

  Widget buildPersonRow(Map data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data["name"],
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(data["phone"], style: const TextStyle(color: Colors.grey)),
          ],
        ),
        Row(
          children: [
            Text(data["rating"].toString(),
                style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(width: 4),
            const Text("★", style: TextStyle(color: Colors.orange)),
          ],
        )
      ],
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
