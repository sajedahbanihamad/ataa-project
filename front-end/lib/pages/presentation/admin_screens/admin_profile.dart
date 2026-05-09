import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final admin = {
      "name": "Admin User",
      "email": "admin@donationplatform.com",
      "phone": "+1 234 567 8999",
      "role": "System Administrator",
    };

    final settingsGroups = [
      {
        "title": "Account",
        "items": [
          {"icon": LucideIcons.user, "label": "Edit Profile", "value": ""},
          {"icon": LucideIcons.mail, "label": "Email", "value": admin["email"]},
          {
            "icon": LucideIcons.phone,
            "label": "Phone",
            "value": admin["phone"]
          },
          {"icon": LucideIcons.lock, "label": "Change Password", "value": ""},
        ],
      },
      {
        "title": "Preferences",
        "items": [
          {
            "icon": LucideIcons.bell,
            "label": "Notifications",
            "value": "Enabled"
          },
          {
            "icon": LucideIcons.helpCircle,
            "label": "Help & Support",
            "value": ""
          },
        ],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Profile Header
          Container(
            padding: const EdgeInsets.all(20),
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
                Container(
                  width: 96,
                  height: 96,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFF529160),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "AU",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  admin["name"] as String,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  admin["role"] as String,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// Settings Groups
          ...settingsGroups.map((group) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
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
                  /// Title
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Text(
                      group["title"] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// Items
                  ...((group["items"] as List).asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value as Map;

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    item["icon"] as IconData,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item["label"] as String,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      if ((item["value"] as String).isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4),
                                          child: Text(
                                            item["value"] as String,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                const Icon(
                                  LucideIcons.chevronRight,
                                  size: 20,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                        if (index != (group["items"] as List).length - 1)
                          Divider(height: 1, color: Colors.grey.shade200),
                      ],
                    );
                  }))
                ],
              ),
            );
          }),

          /// Logout
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {},
            icon: const Icon(LucideIcons.logOut),
            label: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
