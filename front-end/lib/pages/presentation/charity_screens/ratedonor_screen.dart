import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RateDonorScreen extends StatefulWidget {
  const RateDonorScreen({super.key});

  @override
  State<RateDonorScreen> createState() => _RateDonorScreenState();
}

class _RateDonorScreenState extends State<RateDonorScreen> {
  int rating = 0;
  int hoverRating = 0;
  String comment = '';

  void handleSubmit() {
    debugPrint('Rating submitted: $rating, $comment');
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
                Container(
                  padding: const EdgeInsets.all(24),
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
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xFFE5E7EB),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "John Anderson",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const Text(
                        "Verified Donor",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Donation Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            _row("Category", "Food", isBadge: true),
                            _row("Item", "Fresh Vegetables & Fruits"),
                            _row("Date", "May 4, 2026"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "How was your experience?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final star = index + 1;

                          return IconButton(
                            onPressed: () {
                              setState(() {
                                rating = star;
                              });
                            },
                            icon: Icon(
                              LucideIcons.star,
                              size: 36,
                              color: star <= rating
                                  ? const Color(0xFFFBBF24)
                                  : Colors.grey[300],
                            ),
                          );
                        }),
                      ),
                      Text(
                        rating == 0
                            ? "Tap to rate"
                            : rating == 1
                                ? "Poor"
                                : rating == 2
                                    ? "Fair"
                                    : rating == 3
                                        ? "Good"
                                        : rating == 4
                                            ? "Very Good"
                                            : "Excellent",
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        onChanged: (val) => comment = val,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText:
                              "Tell us about your experience with this donor...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: rating == 0 ? null : handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF529160),
                            disabledBackgroundColor: const Color(0xFFE5E7EB),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text("Submit Rating"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Skip for Now",
                          style: TextStyle(color: Color(0xFF6B7280)),
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

  Widget _row(String label, String value, {bool isBadge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 12),
          ),
          isBadge
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF529160),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              : Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ],
      ),
    );
  }
}
