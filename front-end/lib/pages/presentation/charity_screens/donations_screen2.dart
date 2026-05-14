import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyDonationsScreen extends StatefulWidget {
  const MyDonationsScreen({super.key});

  @override
  State<MyDonationsScreen> createState() => _MyDonationsScreenState();
}

class _MyDonationsScreenState extends State<MyDonationsScreen> {
  bool _isActive = true;

  final List<Map<String, dynamic>> _activeDonations = [
    {
      'id': 1,
      'category': 'Food',
      'donor': 'John Anderson',
      'status': 'Pending Pickup',
      'date': 'Today, 2:00 PM',
    },
    {
      'id': 2,
      'category': 'Clothes',
      'donor': 'Sarah Williams',
      'status': 'Confirmed',
      'date': 'Tomorrow, 10:00 AM',
    },
    {
      'id': 3,
      'category': 'Books',
      'donor': 'Mike Johnson',
      'status': 'In Transit',
      'date': 'Today, 4:00 PM',
    },
  ];

  final List<Map<String, dynamic>> _completedDonations = [
    {
      'id': 4,
      'category': 'Food',
      'donor': 'Emma Davis',
      'status': 'Completed',
      'date': 'Apr 28, 2026',
    },
    {
      'id': 5,
      'category': 'Money',
      'donor': 'Robert Chen',
      'status': 'Completed',
      'date': 'Apr 27, 2026',
    },
    {
      'id': 6,
      'category': 'Clothes',
      'donor': 'Lisa Martinez',
      'status': 'Completed',
      'date': 'Apr 25, 2026',
    },
    {
      'id': 7,
      'category': 'Food',
      'donor': 'David Wilson',
      'status': 'Completed',
      'date': 'Apr 24, 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final donations = _isActive ? _activeDonations : _completedDonations;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
          child: Column(
            children: [
              // ── Tab Switcher ──
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    _TabButton(
                      label: 'Active (${_activeDonations.length})',
                      isActive: _isActive,
                      onTap: () => setState(() => _isActive = true),
                    ),
                    _TabButton(
                      label: 'Completed (${_completedDonations.length})',
                      isActive: !_isActive,
                      onTap: () => setState(() => _isActive = false),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Donations List ──
              Expanded(
                child: ListView.separated(
                  itemCount: donations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final donation = donations[index];
                    return _DonationCard(
                      donation: donation,
                      isActive: _isActive,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/confirmation_screen',
                          arguments: donation['donor'],
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

// ─────────────────────────────────────────────
// Tab Button
// ─────────────────────────────────────────────
class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color:
                  isActive ? const Color(0xFF529160) : const Color(0xFF6B7280),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Donation Card
// ─────────────────────────────────────────────
class _DonationCard extends StatelessWidget {
  final Map<String, dynamic> donation;
  final bool isActive;
  final VoidCallback onTap;

  const _DonationCard({
    required this.donation,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // ── Top Row: category + donor + status ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
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
                      // Donor name
                      Text(
                        donation['donor'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ],
                  ),
                ),
                // Status badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFEFF6FF)
                        : const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    donation['status'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isActive
                          ? const Color(0xFF1D4ED8)
                          : const Color(0xFF15803D),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ── Date Row ──
            Row(
              children: [
                const Icon(LucideIcons.calendar,
                    size: 16, color: Color(0xFF529160)),
                const SizedBox(width: 6),
                Text(
                  donation['date'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
