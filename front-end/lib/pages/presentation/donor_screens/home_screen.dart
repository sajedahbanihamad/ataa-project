import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'label': 'Total Donations',
        'value': '247',
        'icon': LucideIcons.package,
        'color': const Color(0xFFF0FDF4),
      },
      {
        'label': 'Active Donations',
        'value': '12',
        'icon': LucideIcons.clock,
        'color': const Color(0xFFEFF6FF),
      },
      {
        'label': 'Completed',
        'value': '235',
        'icon': LucideIcons.checkCircle2,
        'color': const Color(0xFFFAF5FF),
      },
    ];

    final availableDonations = [
      {
        'id': 1,
        'category': 'Food',
        'title': 'Fresh Vegetables & Fruits',
        'location': '2.3 km away',
        'rating': 4.8,
        'time': '2 hours ago',
      },
      {
        'id': 2,
        'category': 'Clothes',
        'title': 'Winter Clothing Items',
        'location': '1.5 km away',
        'rating': 4.9,
        'time': '5 hours ago',
      },
      {
        'id': 3,
        'category': 'Money',
        'title': 'Monthly Support Fund',
        'location': 'Online',
        'rating': 5.0,
        'time': '1 day ago',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Stats Row ──
              Row(
                children: stats.map((stat) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      decoration: BoxDecoration(
                        color: stat['color'] as Color,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            stat['icon'] as IconData,
                            size: 28,
                            color: const Color(0xFF529160),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            stat['value'] as String,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stat['label'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // ── Section Title ──
              const Text(
                'Available Donations Near You',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 12),

              // ── Donations List ──
              Expanded(
                child: ListView.separated(
                  itemCount: availableDonations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final donation = availableDonations[index];
                    return _DonationCard(
                      donation: donation,
                      onViewDetails: () {
                        Navigator.pushNamed(
                          context,
                          '/confirmation_screen',
                          arguments: donation['title'],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonationCard extends StatelessWidget {
  final Map<String, dynamic> donation;
  final VoidCallback onViewDetails;

  const _DonationCard({
    required this.donation,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Row: category badge + rating ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF529160),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        donation['category'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      donation['title'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ),
              // Rating badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.star,
                        size: 14, color: Color(0xFFFBBF24)),
                    const SizedBox(width: 4),
                    Text(
                      donation['rating'].toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── Location + Time ──
          Row(
            children: [
              const Icon(LucideIcons.mapPin,
                  size: 16, color: Color(0xFF529160)),
              const SizedBox(width: 4),
              Text(
                donation['location'] as String,
                style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
              ),
              const SizedBox(width: 8),
              const Text('•', style: TextStyle(color: Color(0xFF9CA3AF))),
              const SizedBox(width: 8),
              Text(
                donation['time'] as String,
                style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ── View Details Button ──
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onViewDetails,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF529160),
                side: const BorderSide(color: Color(0xFF529160), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
