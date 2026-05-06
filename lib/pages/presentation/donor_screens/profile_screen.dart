import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:Ataa/models/user_profile.dart';
import 'package:Ataa/services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  void fetchProfile() async {
    final result = await ApiService.getProfile();

    setState(() {
      user = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  "Profile",
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 32),

                /// Avatar + Name
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color(0xFF529160), width: 4),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          color: const Color(0xFFE0E0E0),
                        ),
                        child: const Icon(LucideIcons.user,
                            size: 60, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),

                      /// 🟢 الاسم (مؤقت استخدمنا الإيميل)
                      Text(
                        user?.email ?? "",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),

                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(LucideIcons.mapPin,
                              size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("Amman, Jordan",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Stats
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      _statItem(
                        user?.mealsDonated.toString() ?? "0",
                        "Meals Donated",
                        LucideIcons.heart,
                      ),
                      _divider(),
                      _statItem(
                        user?.foodSaved.toString() ?? "0",
                        "Food Saved",
                        LucideIcons.package,
                      ),
                      _divider(),
                      _statItem(
                        user?.rating.toString() ?? "0",
                        "Rating",
                        LucideIcons.star,
                        star: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Personal Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Personal Information",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _infoItem(LucideIcons.user, "User ID",
                              user?.userId.toString() ?? ""),
                          _infoItem(
                            LucideIcons.mail,
                            "Email",
                            user?.email ?? "",
                          ),
                          _infoItem(
                              LucideIcons.award, "Role", user?.role ?? ""),
                          _infoItem(LucideIcons.star, "Total Ratings",
                              user?.totalRatings.toString() ?? ""),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Logout
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login_screen',
                      (route) => false,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF529160),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(LucideIcons.logOut, color: Colors.white),
                        SizedBox(width: 8),
                        Text("Log Out", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 50,
      color: Colors.grey.shade300,
    );
  }

  Widget _statItem(String number, String label, IconData icon,
      {bool star = false}) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon,
              color: star ? Colors.amber : const Color(0xFF529160), size: 16),
          const SizedBox(height: 6),
          Text(number,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}
