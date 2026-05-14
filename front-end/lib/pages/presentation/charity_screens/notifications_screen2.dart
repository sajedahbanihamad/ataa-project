import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CharityNotificationsScreen extends StatelessWidget {
  const CharityNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'id': 1,
        'icon': LucideIcons.package,
        'message': 'New donation available near you',
        'time': '5 minutes ago',
        'unread': true,
      },
      {
        'id': 2,
        'icon': LucideIcons.checkCircle2,
        'message': 'Donation pickup confirmed for tomorrow at 10:00 AM',
        'time': '2 hours ago',
        'unread': true,
      },
      {
        'id': 3,
        'icon': LucideIcons.bell,
        'message': 'Reminder: Pickup scheduled for today at 2:00 PM',
        'time': '5 hours ago',
        'unread': false,
      },
      {
        'id': 4,
        'icon': LucideIcons.checkCircle2,
        'message': 'Donation successfully completed',
        'time': '1 day ago',
        'unread': false,
      },
      {
        'id': 5,
        'icon': LucideIcons.package,
        'message': 'New donation available: Winter Clothing Items',
        'time': '2 days ago',
        'unread': false,
      },
      {
        'id': 6,
        'icon': LucideIcons.alertCircle,
        'message': 'Donation time updated by donor',
        'time': '3 days ago',
        'unread': false,
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
              // ── Back Button ──
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(LucideIcons.arrowLeft,
                        size: 20, color: Color(0xFF374151)),
                    SizedBox(width: 8),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Notifications List ──
              Expanded(
                child: ListView.separated(
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final n = notifications[index];
                    return _NotificationCard(notification: n);
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
// Notification Card
// ─────────────────────────────────────────────
class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    final bool unread = notification['unread'] as bool;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unread ? const Color(0xFF529160) : const Color(0xFFF3F4F6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Icon Circle ──
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFF0FDF4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              notification['icon'] as IconData,
              size: 24,
              color: const Color(0xFF529160),
            ),
          ),

          const SizedBox(width: 16),

          // ── Message + Time ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['message'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification['time'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          // ── Unread Dot ──
          if (unread) ...[
            const SizedBox(width: 8),
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF529160),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
