import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:Ataa/pages/presentation/charity_screens/ratedonor_screen.dart';

class CharityHistoryScreen extends StatelessWidget {
  const CharityHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyItems = [
      {
        'id': 1,
        'category': 'Food',
        'date': 'Apr 28, 2026',
        'icon': LucideIcons.package
      },
      {
        'id': 2,
        'category': 'Money',
        'date': 'Apr 27, 2026',
        'icon': LucideIcons.dollarSign
      },
      {
        'id': 3,
        'category': 'Clothes',
        'date': 'Apr 25, 2026',
        'icon': LucideIcons.shirt
      },
      {
        'id': 4,
        'category': 'Food',
        'date': 'Apr 24, 2026',
        'icon': LucideIcons.package
      },
      {
        'id': 5,
        'category': 'Books',
        'date': 'Apr 22, 2026',
        'icon': LucideIcons.book
      },
      {
        'id': 6,
        'category': 'Money',
        'date': 'Apr 20, 2026',
        'icon': LucideIcons.dollarSign
      },
      {
        'id': 7,
        'category': 'Clothes',
        'date': 'Apr 18, 2026',
        'icon': LucideIcons.shirt
      },
      {
        'id': 8,
        'category': 'Food',
        'date': 'Apr 15, 2026',
        'icon': LucideIcons.package
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: historyItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = historyItems[index];

        return Container(
          padding: const EdgeInsets.all(16),
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
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0FDF4),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: const Color(0xFF529160),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['category'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              LucideIcons.calendar,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item['date'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Completed',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF166534),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RateDonorScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF529160)),
                    foregroundColor: const Color(0xFF529160),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'Rate Donor',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
