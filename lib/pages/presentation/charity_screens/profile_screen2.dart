import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CharityProfileScreen extends StatefulWidget {
  const CharityProfileScreen({super.key});

  @override
  State<CharityProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<CharityProfileScreen> {
  List<String> selectedNeeds = [
    'Winter Clothes',
    'Food Packages',
    'Financial Support'
  ];

  bool isDropdownOpen = false;

  final List<String> allNeeds = [
    'Winter Clothes',
    'Food Packages',
    'School Supplies',
    'Financial Support',
    'Blankets',
    'Medicine',
  ];

  void toggleNeed(String need) {
    setState(() {
      if (selectedNeeds.contains(need)) {
        selectedNeeds.remove(need);
      } else {
        selectedNeeds.add(need);
      }
    });
  }

  void removeNeed(String need) {
    setState(() {
      selectedNeeds.remove(need);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ───── PROFILE CARD ─────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF3F4F6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            "HC",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF529160),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Hope Community Center",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        "Verified Charity Organization",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _infoRow(
                          LucideIcons.mail, "Email", "contact@hopecenter.org"),
                      _infoRow(LucideIcons.phone, "Phone", "+1 (555) 123-4567"),
                      _infoRow(LucideIcons.mapPin, "Location",
                          "456 Community Lane,Green Valley,CA 94105"),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon:
                              const Icon(LucideIcons.logOut, color: Colors.red),
                          label: const Text("Logout"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ───── NEEDS CARD ─────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF3F4F6)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Current Needs",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDropdownOpen = !isDropdownOpen;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Select current needs",
                                  style: TextStyle(color: Colors.grey)),
                              Icon(LucideIcons.chevronDown),
                            ],
                          ),
                        ),
                      ),
                      if (isDropdownOpen)
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: allNeeds.map((need) {
                              final selected = selectedNeeds.contains(need);

                              return ListTile(
                                title: Text(need),
                                trailing: selected
                                    ? const Icon(Icons.check,
                                        color: Color(0xFF529160))
                                    : null,
                                onTap: () => toggleNeed(need),
                              );
                            }).toList(),
                          ),
                        ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedNeeds.map((need) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF529160),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  need,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => removeNeed(need),
                                  child: const Icon(
                                    LucideIcons.x,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "These needs may change based on events and seasons",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF529160)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Icon(icon, color: const Color(0xFF529160)),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            Text(label,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        )
      ],
    );
  }
}
