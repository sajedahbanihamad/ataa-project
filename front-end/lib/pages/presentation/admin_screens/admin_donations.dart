import 'package:Ataa/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AdminDonations extends StatefulWidget {
  const AdminDonations({super.key});

  @override
  State<AdminDonations> createState() => _DonationsState();
}

class _DonationsState extends State<AdminDonations> {
  String categoryFilter = "All";
  String statusFilter = "All";

  final categories = ["All", "Food", "Clothes", "Money", "Books", "Other"];
  final statuses = ["All", "Pending", "Accepted", "Completed", "Cancelled"];

  final donations = [
    {
      "id": 1,
      "category": "Food",
      "donor": "John Doe",
      "charity": "Food Bank Network",
      "status": "Accepted",
      "date": "Apr 30, 2026"
    },
    {
      "id": 2,
      "category": "Clothes",
      "donor": "Sarah Smith",
      "charity": null,
      "status": "Pending",
      "date": "Apr 30, 2026"
    },
    {
      "id": 3,
      "category": "Money",
      "donor": "Michael Brown",
      "charity": "Hope Foundation",
      "status": "Completed",
      "date": "Apr 29, 2026"
    },
    {
      "id": 4,
      "category": "Books",
      "donor": "Emily Davis",
      "charity": "Education First",
      "status": "Accepted",
      "date": "Apr 29, 2026"
    },
    {
      "id": 5,
      "category": "Food",
      "donor": "David Wilson",
      "charity": "Community Kitchen",
      "status": "Completed",
      "date": "Apr 28, 2026"
    },
    {
      "id": 6,
      "category": "Clothes",
      "donor": "Lisa Anderson",
      "charity": null,
      "status": "Cancelled",
      "date": "Apr 28, 2026"
    },
    {
      "id": 7,
      "category": "Other",
      "donor": "James Taylor",
      "charity": "Help Center",
      "status": "Pending",
      "date": "Apr 27, 2026"
    },
    {
      "id": 8,
      "category": "Money",
      "donor": "Anna Martin",
      "charity": "Save Lives",
      "status": "Accepted",
      "date": "Apr 27, 2026"
    },
  ];

  Color getStatusBg(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange.shade100;
      case "Accepted":
        return Colors.blue.shade100;
      case "Completed":
        return Colors.green.shade100;
      case "Cancelled":
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusText(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Accepted":
        return Colors.blue;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getCategoryIcon(String category) {
    return category[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDonations = donations.where((d) {
      final matchCategory =
          categoryFilter == "All" || d["category"] == categoryFilter;
      final matchStatus = statusFilter == "All" || d["status"] == statusFilter;
      return matchCategory && matchStatus;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Filters
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4)
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.filter_alt_outlined, size: 18),
                    SizedBox(width: 6),
                    Text("Filters",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 10),

                /// Category
                const Text("Category", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: categories.map((cat) {
                    final selected = categoryFilter == cat;
                    return GestureDetector(
                      onTap: () => setState(() => categoryFilter = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color:
                              selected ? const Color(0xFF529160) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF529160)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                /// Status
                const Text("Status", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: statuses.map((status) {
                    final selected = statusFilter == status;
                    return GestureDetector(
                      onTap: () => setState(() => statusFilter = status),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color:
                              selected ? const Color(0xFF529160) : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF529160)
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// Donations List
          ...filteredDonations.map((donation) {
            return GestureDetector(
              onTap: () {
                // navigation مثل React Link
                Navigator.pushNamed(
                  context,
                  AppRoutes.admindonationDetails,
                  arguments: donation["id"].toString(),
                );
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
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF529160),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        getCategoryIcon(donation["category"] as String),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                                  donation["category"] as String,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color:
                                      getStatusBg(donation["status"] as String),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  donation["status"] as String,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: getStatusText(
                                        donation["status"] as String),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text("Donor: ${donation["donor"]}",
                              style: const TextStyle(color: Colors.grey)),
                          if (donation["charity"] != null)
                            Text("Charity: ${donation["charity"]}",
                                style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            donation["date"] as String,
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
    );
  }
}
