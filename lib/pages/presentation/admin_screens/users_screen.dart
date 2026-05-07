import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String activeTab = "donors";

  final donors = [
    {
      "id": 1,
      "name": "John Doe",
      "rating": 4.8,
      "status": "Active",
      "donations": 24
    },
    {
      "id": 2,
      "name": "Sarah Smith",
      "rating": 4.6,
      "status": "Active",
      "donations": 18
    },
    {
      "id": 3,
      "name": "Michael Brown",
      "rating": 4.9,
      "status": "Active",
      "donations": 32
    },
    {
      "id": 4,
      "name": "Emily Davis",
      "rating": 4.5,
      "status": "Suspended",
      "donations": 12
    },
    {
      "id": 5,
      "name": "David Wilson",
      "rating": 4.7,
      "status": "Active",
      "donations": 21
    },
    {
      "id": 6,
      "name": "Lisa Anderson",
      "rating": 4.4,
      "status": "Active",
      "donations": 9
    },
  ];

  final charities = [
    {
      "id": 7,
      "name": "Food Bank Network",
      "rating": 4.9,
      "status": "Active",
      "received": 156
    },
    {
      "id": 8,
      "name": "Hope Foundation",
      "rating": 4.8,
      "status": "Active",
      "received": 142
    },
    {
      "id": 9,
      "name": "Save Lives",
      "rating": 4.7,
      "status": "Active",
      "received": 98
    },
    {
      "id": 10,
      "name": "Community Kitchen",
      "rating": 4.6,
      "status": "Suspended",
      "received": 67
    },
    {
      "id": 11,
      "name": "Education First",
      "rating": 4.9,
      "status": "Active",
      "received": 203
    },
  ];

  @override
  Widget build(BuildContext context) {
    final displayUsers = activeTab == "donors" ? donors : charities;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Tabs
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4)
              ],
            ),
            child: Row(
              children: [
                buildTab("donors", "Donors"),
                buildTab("charities", "Charities"),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// Users List
          ...displayUsers.map((user) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/users/${user["id"]}");
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4)
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        activeTab == "donors"
                            ? LucideIcons.user
                            : LucideIcons.building2,
                        color: Colors.grey,
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
                                  user["name"] as String,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    user["rating"].toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text("★",
                                      style: TextStyle(color: Colors.orange)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activeTab == "donors"
                                ? "${user["donations"]} donations posted"
                                : "${user["received"]} donations received",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
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
                      ),
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget buildTab(String value, String label) {
    final selected = activeTab == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => activeTab = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF529160) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
