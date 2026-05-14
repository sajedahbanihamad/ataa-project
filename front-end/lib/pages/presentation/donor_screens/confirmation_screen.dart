import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DonationConfirmationScreen extends StatelessWidget {
  const DonationConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String charityName = args?["charity"] ?? "Food Bank Central";
    final bool aiMatch = args?["aiMatch"] ?? false;

    final String donationId = "DON-${_generateRandomString(6).toUpperCase()}";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// Success
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.checkCircle2,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Donation Confirmed!",
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Your donation has been successfully created",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF529160), Color(0xFF3D6D48)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Donation ID",
                          style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 4),
                      Text(
                        donationId,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white24),
                      const SizedBox(height: 10),
                      const Text("Going to",
                          style: TextStyle(color: Colors.white70)),
                      Text(
                        charityName,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                _infoCard(
                  icon: LucideIcons.calendar,
                  title: "Pickup Date",
                  main: "Tomorrow",
                  sub: "10:00 AM - 2:00 PM",
                ),
                _infoCard(
                  icon: LucideIcons.mapPin,
                  title: "Pickup Location",
                  main: "Your Address",
                  sub: "Saved location",
                ),
                _infoCard(
                  icon: LucideIcons.package,
                  title: "Status",
                  main: "Pending Pickup",
                  sub: "You'll get updates",
                ),

                /// ✅ AI MATCH BOX (مثل الصورة)
                if (aiMatch)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFDBEAFE)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI-Powered Match",
                          style: TextStyle(
                            color: Color(0xFF1D4ED8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "This donation was optimized for maximum impact using our AI matching system.",
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 20),

                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home_screen');
                  },
                  icon: const Icon(LucideIcons.home, size: 18),
                  label: const Text("Back to Home"),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String main,
    required String sub,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF529160)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(main),
              Text(sub,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }

  String _generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final rand = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rand.nextInt(chars.length)),
      ),
    );
  }
}
