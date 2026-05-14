import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String timeFilter = "weekly";

  final List<Map<String, dynamic>> categoryData = [
    {"name": "Food", "donations": 856},
    {"name": "Clothes", "donations": 634},
    {"name": "Money", "donations": 968},
    {"name": "Books", "donations": 412},
    {"name": "Other", "donations": 288},
  ];

  final topDonors = [
    {"name": "Michael Brown", "donations": 32, "amount": "\$12,400"},
    {"name": "Anna Martin", "donations": 28, "amount": "\$10,800"},
    {"name": "John Doe", "donations": 24, "amount": "\$9,200"},
    {"name": "Sarah Smith", "donations": 18, "amount": "\$7,600"},
  ];

  final topCharities = [
    {"name": "Education First", "received": 203},
    {"name": "Food Bank Network", "received": 156},
    {"name": "Hope Foundation", "received": 142},
    {"name": "Save Lives", "received": 98},
  ];

  List<BarChartGroupData> getChartData() {
    return List.generate(categoryData.length, (index) {
      final item = categoryData[index];

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: item["donations"].toDouble(),
            color: const Color(0xFF529160),
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Time Filter
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
                const Text("Time Period", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  children: ["weekly", "monthly"].map((period) {
                    final selected = timeFilter == period;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => timeFilter = period),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF529160)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF529160)
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            period[0].toUpperCase() + period.substring(1),
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.black87,
                            ),
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

          /// Stats
          Row(
            children: [
              buildStat(LucideIcons.trendingUp, Colors.green, "3,158", "Total"),
              buildStat(LucideIcons.users, Colors.blue, "834", "Users"),
              buildStat(
                  LucideIcons.dollarSign, Colors.purple, "\$2.4M", "Value"),
            ],
          ),

          const SizedBox(height: 12),

          /// Chart
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Donations by Category",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      barGroups: getChartData(),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          buildList(
            title: "Most Active Donors",
            data: topDonors,
            isDonor: true,
          ),

          buildList(
            title: "Most Active Charities",
            data: topCharities,
            isDonor: false,
          ),
        ],
      ),
    );
  }

  Widget buildStat(IconData icon, Color color, String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(label,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget buildList(
      {required String title, required List data, required bool isDonor}) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
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
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ...data.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;

            return Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor:
                        isDonor ? const Color(0xFF529160) : Colors.blue,
                    child: Text("${index + 1}",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item["name"],
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                          isDonor
                              ? "${item["donations"]} donations"
                              : "${item["received"]} received",
                          style:
                              const TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  if (isDonor)
                    Text(item["amount"],
                        style: const TextStyle(color: Color(0xFF529160))),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
