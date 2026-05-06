import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CreateDonationScreen extends StatelessWidget {
  const CreateDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "id": "food",
        "name": "Food",
        "icon": LucideIcons.utensils,
        "color": Color(0xFFFFEDD5),
        "iconColor": Color(0xFFEA580C)
      },
      {
        "id": "clothing",
        "name": "Clothes",
        "icon": LucideIcons.shirt,
        "color": Color(0xFFF3E8FF),
        "iconColor": Color(0xFF9333EA)
      },
      {
        "id": "books",
        "name": "Books",
        "icon": LucideIcons.book,
        "color": Color(0xFFDBEAFE),
        "iconColor": Color(0xFF2563EB)
      },
      {
        "id": "medicine",
        "name": "Medicine",
        "icon": LucideIcons.heart,
        "color": Color(0xFFFEE2E2),
        "iconColor": Color(0xFFDC2626)
      },
      {
        "id": "furniture",
        "name": "Furniture",
        "icon": LucideIcons.sofa,
        "color": Color(0xFFFEF3C7),
        "iconColor": Color(0xFFD97706)
      },
      {
        "id": "electronics",
        "name": "Electronics",
        "icon": LucideIcons.laptop,
        "color": Color(0xFFCFFAFE),
        "iconColor": Color(0xFF0891B2)
      },
      {
        "id": "toys",
        "name": "Toys",
        "icon": LucideIcons.palette,
        "color": Color(0xFFFCE7F3),
        "iconColor": Color(0xFFDB2777)
      },
      {
        "id": "other",
        "name": "Other",
        "icon": LucideIcons.briefcase,
        "color": Color(0xFFF3F4F6),
        "iconColor": Color(0xFF4B5563)
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        size: 24, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Create Donation",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// SUBTITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select donation category",
                  style: TextStyle(color: Color(0xFF6B7280)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/donationdetails_screen',
                          arguments: category["name"],
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color(0xFFF3F4F6), width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ICON BOX
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: category["color"] as Color,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                category["icon"] as IconData,
                                color: category["iconColor"] as Color,
                              ),
                            ),

                            const Spacer(),

                            /// TEXT
                            Text(
                              category["name"] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
